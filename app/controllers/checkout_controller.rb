class CheckoutController < ApplicationController
  # This Devise helper forces users to log in before seeing the checkout
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
end