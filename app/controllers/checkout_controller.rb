class CheckoutController < ApplicationController
  before_action :authenticate_customer!

  def index
    @cart_items = Product.find(session[:cart].keys)
    
    @subtotal = 0
    @cart_items.each do |product|
      quantity = session[:cart][product.id.to_s].to_i
      @subtotal += product.price * quantity
    end

    @province = current_customer.province
    
    @gst = @subtotal * @province.gst
    @pst = @subtotal * @province.pst
    @hst = @subtotal * @province.hst
    
    @total = @subtotal + @gst + @pst + @hst
  end

  def create
    @cart_items = Product.find(session[:cart].keys)
    @province = current_customer.province

    if @cart_items.empty?
      redirect_to root_path, alert: "Your cart is empty."
      return
    end

    # Recalculate totals securely on the server
    subtotal = 0
    @cart_items.each do |product|
      quantity = session[:cart][product.id.to_s].to_i
      subtotal += product.price * quantity
    end

    gst = subtotal * @province.gst
    pst = subtotal * @province.pst
    hst = subtotal * @province.hst
    total = subtotal + gst + pst + hst

    # 1. Create the Order Record
    order = current_customer.orders.build(
      subtotal: subtotal,
      gst: gst,
      pst: pst,
      hst: hst,
      total: total,
      status: "New"
    )

    if order.save
      # 2. Create the Line Item Records
      @cart_items.each do |product|
        quantity = session[:cart][product.id.to_s].to_i
        order.line_items.create(
          product: product,
          quantity: quantity,
          price: product.price # Saves the price at the exact moment of purchase
        )
      end

      # 3. Clear the Cart Session
      session[:cart] = {}

      redirect_to root_path, notice: "Order successfully placed! Thank you for your purchase."
    else
      redirect_to checkout_path, alert: "There was an issue processing your order. Please try again."
    end
  end
end