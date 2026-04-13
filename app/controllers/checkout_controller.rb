class CheckoutController < ApplicationController
  before_action :authenticate_customer!

  def index
    @cart = session[:cart] || {}
    if @cart.empty?
      redirect_to root_path, alert: "Your cart is empty."
      return
    end

    @province = current_customer.province
    @subtotal = 0
    @cart.each do |product_id, quantity|
      product = Product.find_by(id: product_id)
      @subtotal += (product.price * quantity) if product
    end

    @gst = @subtotal * (@province.gst || 0)
    @pst = @subtotal * (@province.pst || 0)
    @hst = @subtotal * (@province.hst || 0)
    @total = @subtotal + @gst + @pst + @hst
  end

  def create
    # HARD-CODED KEY: This ensures the controller uses the correct key immediately
    Stripe.api_key = 'sk_test_51THHZcCrPyiHw7vH3zXXD2gWiVV9wCzidmP2F9bKvBmiLRhzAyssc0XO0UtBUGluZjVPcAoGvonzY0FhE01CADeDY00Cxm7ouM1'
    
    @cart = session[:cart] || {}
    @province = current_customer.province
    
    line_items = []
    subtotal = 0

    @cart.each do |product_id, quantity|
      product = Product.find_by(id: product_id)
      if product
        subtotal += product.price * quantity
        line_items << {
          price_data: {
            currency: 'cad',
            product_data: { name: product.product_name },
            unit_amount: (product.price * 100).to_i
          },
          quantity: quantity
        }
      end
    end

    # Add Tax line items
    line_items << { price_data: { currency: 'cad', product_data: { name: 'GST' }, unit_amount: (subtotal * @province.gst * 100).to_i }, quantity: 1 } if @province.gst.to_f > 0
    line_items << { price_data: { currency: 'cad', product_data: { name: 'PST' }, unit_amount: (subtotal * @province.pst * 100).to_i }, quantity: 1 } if @province.pst.to_f > 0
    line_items << { price_data: { currency: 'cad', product_data: { name: 'HST' }, unit_amount: (subtotal * @province.hst * 100).to_i }, quantity: 1 } if @province.hst.to_f > 0

    @session = Stripe::Checkout::Session.create(
      payment_method_types: ['card'],
      mode: 'payment',
      success_url: checkout_success_url + "?session_id={CHECKOUT_SESSION_ID}",
      cancel_url: checkout_cancel_url,
      customer_email: current_customer.email,
      line_items: line_items
    )

    redirect_to @session.url, allow_other_host: true
  end

  def success
    session[:cart] = {}
    redirect_to root_path, notice: "Payment successful!"
  end

  def cancel
    redirect_to cart_path, alert: "Payment cancelled."
  end
end