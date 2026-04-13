class CartsController < ApplicationController
  def show
    # Fetch the cart from the session, or default to an empty hash
    @cart = session[:cart] || {}
    
    # Safely query the database for products that match the IDs in the cart
    @products = Product.where(id: @cart.keys)
    
    # Calculate the subtotal before taxes
    @subtotal = 0
    @products.each do |product|
      quantity = @cart[product.id.to_s].to_i
      @subtotal += (product.price * quantity)
    end
  end

  def add
    id = params[:product_id].to_s
    session[:cart] ||= {}
    session[:cart][id] = (session[:cart][id] || 0) + 1
    
    flash[:notice] = "Product added to cart."
    redirect_back(fallback_location: products_path)
  end

  def remove
    id = params[:product_id].to_s
    session[:cart].delete(id)
    
    flash[:notice] = "Product removed from cart."
    redirect_to cart_path
  end

  def update
    id = params[:product_id].to_s
    quantity = params[:quantity].to_i
    
    if quantity > 0
      session[:cart][id] = quantity
      flash[:notice] = "Cart updated."
    else
      session[:cart].delete(id)
      flash[:notice] = "Product removed from cart."
    end
    
    redirect_to cart_path
  end
end