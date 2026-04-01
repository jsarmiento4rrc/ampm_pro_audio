class OrdersController < ApplicationController
  before_action :authenticate_customer!

  def index
    # Fetch all orders for the current user, newest first
    @orders = current_customer.orders.order(created_at: :desc)
  end

  def show
    # Fetch a specific order, ensuring it belongs to the current user for security
    @order = current_customer.orders.find(params[:id])
  end
end