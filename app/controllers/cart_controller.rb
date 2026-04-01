class CartController < ApplicationController
  def add
    product_id = params[:product_id].to_s
    quantity = params[:quantity].to_i

    # Initialize cart if it doesn't exist, then save the quantity
    session[:cart] ||= {}
    session[:cart][product_id] = quantity

    # Redirect back to the catalog so they can keep shopping
    redirect_to root_path, notice: "Item successfully added to your cart."
  end

  def update
    product_id = params[:product_id].to_s
    quantity = params[:quantity].to_i

    session[:cart][product_id] = quantity

    # Redirect back to the checkout/cart page to see the updated math
    redirect_to checkout_path, notice: "Cart updated."
  end

  def remove
    product_id = params[:product_id].to_s
    session[:cart].delete(product_id)

    # Redirect back to the checkout/cart page
    redirect_to checkout_path, notice: "Item removed from cart."
  end
end