class ProductsController < ApplicationController
  def index
    @categories = Category.all
    @products = Product.all

    # Keyword Search
    if params[:keyword].present?
      @products = @products.where("product_name LIKE ? OR description LIKE ?", "%#{params[:keyword]}%", "%#{params[:keyword]}%")
    end

    # Category Filter
    if params[:category_id].present?
      @products = @products.where(category_id: params[:category_id])
    end

    # Requirement 2.4: Filters for New/Updated
    if params[:filter] == 'new'
      @products = @products.where("created_at >= ?", 3.days.ago)
    elsif params[:filter] == 'updated'
      @products = @products.where("updated_at >= ? AND created_at < ?", 3.days.ago, 3.days.ago)
    end

    # Requirement 2.5: Pagination (10 products per page)
    @products = @products.page(params[:page]).per(10)
  end

  def show
    @product = Product.find(params[:id])
  end
end