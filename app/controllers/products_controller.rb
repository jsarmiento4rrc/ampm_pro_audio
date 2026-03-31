class ProductsController < ApplicationController
  def index
    # Start with all products
    @products = Product.includes(:category).all

    # Filter by keyword in product_name OR description
    if params[:keyword].present?
      wildcard_search = "%#{params[:keyword]}%"
      @products = @products.where("product_name LIKE ? OR description LIKE ?", wildcard_search, wildcard_search)
    end

    # Filter by specific category drop-down
    if params[:category_id].present?
      @products = @products.where(category_id: params[:category_id])
    end

    # Feature 2.5: Paginate the final result (10 products per page)
    @products = @products.page(params[:page]).per(10)
  end

  def show
    @product = Product.find(params[:id])
  end
end