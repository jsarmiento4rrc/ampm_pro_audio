class CartController < ApplicationController
  def show
    @cart_items = Product.find(session[:cart].keys) rescue []
  end

  def add
    product_id = params[:product_id].to_s
    quantity = params[:quantity].to_i

    if session[:cart][product_id]
      session[:cart][product_id] += quantity
    else
      session[:cart][product_id] = quantity
    end

    redirect_to cart_path
  end

  def update
    product_id = params[:product_id].to_s
    quantity = params[:quantity].to_i

    if quantity > 0
      session[:cart][product_id] = quantity
    else
      session[:cart].delete(product_id)
    end

    redirect_to cart_path
  end

  def remove
    product_id = params[:product_id].to_s
    session[:cart].delete(product_id)
    redirect_to cart_path
  end
end