class CheckoutController < ApplicationController
  before_action :authenticate_customer!

  def create
    # 1. Initialize Stripe with your secret key from the configuration
    Stripe.api_key = Rails.configuration.stripe[:secret_key]

    # 2. Get the products from the session cart
    cart = session[:cart] || {}
    @products = Product.find(cart.keys)

    if @products.empty?
      redirect_to root_path, alert: "Your cart is empty."
      return
    end

    # 3. Calculate Taxes based on Customer's Province (Requirement 3.3.1)
    province = current_customer.province
    gst_rate = province&.gst || 0
    pst_rate = province&.pst || 0
    hst_rate = province&.hst || 0

    # 4. Build Stripe Line Items
    stripe_line_items = @products.map do |product|
      quantity = cart[product.id.to_s]
      {
        price_data: {
          currency: 'cad',
          product_data: {
            name: product.product_name,
            description: product.description,
          },
          unit_amount: (product.price * 100).to_i, # Stripe uses cents
        },
        quantity: quantity,
      }
    end

    # 5. Add Taxes as separate line items (Requirement 3.3.1)
    subtotal = @products.sum { |p| p.price * cart[p.id.to_s] }
    
    if gst_rate > 0
      stripe_line_items << {
        price_data: {
          currency: 'cad',
          product_data: { name: 'GST', description: "Goods and Services Tax (#{gst_rate * 100}%)" },
          unit_amount: (subtotal * gst_rate * 100).to_i,
        },
        quantity: 1,
      }
    end

    if pst_rate > 0
      stripe_line_items << {
        price_data: {
          currency: 'cad',
          product_data: { name: 'PST', description: "Provincial Sales Tax (#{pst_rate * 100}%)" },
          unit_amount: (subtotal * pst_rate * 100).to_i,
        },
        quantity: 1,
      }
    end

    if hst_rate > 0
      stripe_line_items << {
        price_data: {
          currency: 'cad',
          product_data: { name: 'HST', description: "Harmonized Sales Tax (#{hst_rate * 100}%)" },
          unit_amount: (subtotal * hst_rate * 100).to_i,
        },
        quantity: 1,
      }
    end

    # 6. Create Stripe Session
    @session = Stripe::Checkout::Session.create({
      payment_method_types: ['card'],
      line_items: stripe_line_items,
      mode: 'payment',
      success_url: checkout_success_url + "?session_id={CHECKOUT_SESSION_ID}",
      cancel_url: checkout_cancel_url,
      customer_email: current_customer.email,
    })

    redirect_to @session.url, allow_other_host: true, status: 303
  end

  def success
    # Initialize Stripe key for the retrieval
    Stripe.api_key = Rails.configuration.stripe[:secret_key]
    
    # Retrieve the session to get payment details
    @session = Stripe::Checkout::Session.retrieve(params[:session_id])
    
    # Requirement 3.3.2 & 3.2.1: Create the permanent order record
    @order = current_customer.orders.create!(
      stripe_payment_id: @session.id,
      subtotal: @session.amount_subtotal / 100.0,
      gst: (@session.total_details.amount_tax / 100.0 if @session.total_details.amount_tax),
      total: @session.amount_total / 100.0,
      status: 'paid'
    )

    # Move items from session cart to permanent LineItems
    cart = session[:cart] || {}
    cart.each do |product_id, quantity|
      product = Product.find(product_id)
      @order.line_items.create!(
        product: product,
        quantity: quantity,
        price: product.price # Saves the price at the moment of purchase for data integrity
      )
    end

    # Requirement 4.2.3: Provide clear feedback and clear the cart
    session[:cart] = {}
    flash.now[:notice] = "Payment confirmed!"
  end

  def cancel
    flash[:alert] = "Payment was cancelled. Your cart is still saved."
    redirect_to cart_path
  end
end