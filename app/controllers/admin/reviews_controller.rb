class Admin::ReviewsController < ApplicationController
  before_action :authenticate_user!
  before_action :require_admin!

  def index
    @reviews = Review
      .includes(:user, :product)
      .order(created_at: :desc)
      .page(params[:page])
      .per(15)
  end

  def destroy
    review = Review.find(params[:id])
    review.destroy

    redirect_to admin_reviews_path, notice: "Відгук видалено"
  end

  private

  def require_admin!
    redirect_to root_path unless current_user.role == "manager"
  end
end
