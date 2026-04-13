class CartsController < ApplicationController
  # This is the "show" action your error is asking for
  def show
    @cart_items = []
    session[:cart].each do |product_id, quantity|
      product = Product.find_by(id: product_id)
      if product
        @cart_items << { product: product, quantity: quantity }
      end
    end
  end

  # This is the "add" action triggered by the Product Show page
  def add
    id = params[:id].to_s
    quantity = params[:quantity].to_i
    quantity = 1 if quantity <= 0

    session[:cart] ||= {}
    
    if session[:cart][id]
      session[:cart][id] += quantity
    else
      session[:cart][id] = quantity
    end

    redirect_back fallback_location: root_path, notice: "Added to cart successfully!"
  end

  def update
    id = params[:id].to_s
    quantity = params[:quantity].to_i
    
    if quantity <= 0
      session[:cart].delete(id)
    else
      session[:cart][id] = quantity
    end
    
    redirect_to cart_path, notice: "Cart updated."
  end

  def remove
    id = params[:id].to_s
    session[:cart].delete(id)
    redirect_to cart_path, alert: "Item removed from cart."
  end
end