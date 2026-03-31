class ProductsController < ApplicationController
  def index
    @products = Product.includes(:category).all

    if params[:keyword].present?
      wildcard_search = "%#{params[:keyword]}%"
      @products = @products.where("product_name LIKE ? OR description LIKE ?", wildcard_search, wildcard_search)
    end

    if params[:category_id].present?
      @products = @products.where(category_id: params[:category_id])
    end

    if params[:filter] == "new"
      @products = @products.where("created_at >= ?", 3.days.ago)
    elsif params[:filter] == "recently_updated"
      @products = @products.where("updated_at >= ? AND created_at < ?", 3.days.ago, 3.days.ago)
    end

    @products = @products.page(params[:page]).per(10)
  end

  def show
    @product = Product.find(params[:id])
  end
end