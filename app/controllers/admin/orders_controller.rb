class Admin::OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :require_admin!

  def index
    @orders = Order
      .includes(:user)
      .order(created_at: :desc)
      .page(params[:page])
      .per(15)
  end

  def show
    @order = Order
      .includes(order_items: :product)
      .find(params[:id])
  end

  def update
    order = Order.find(params[:id])

    if Order.statuses.keys.include?(params[:order][:status])
      order.update(status: params[:order][:status])
    end

    redirect_to admin_order_path(order), notice: "Статус оновлено"
  end

  private

  def require_admin!
    redirect_to root_path unless current_user.role == "manager"
  end


end
