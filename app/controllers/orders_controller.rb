class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_order, only: :show

  def index
    @orders = current_user.orders
      .includes(:order_items)
      .order(created_at: :desc)
  end

  def show
    @order_items = @order.order_items.includes(:product)
  end

  private

  def set_order
    @order = current_user.orders.find(params[:id])
  end
end
