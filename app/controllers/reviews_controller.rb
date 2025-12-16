class ReviewsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_product

  def create
    @review = @product.reviews.build(review_params)
    @review.user = current_user
    @review.approved = true 

    if @review.save
      redirect_to product_path(@product), notice: "Дякуємо за відгук 💬"
    else
      @reviews = @product.reviews.includes(:user)
      render "products/show", status: :unprocessable_entity
    end
  end

  private

  def set_product
    @product = Product.find(params[:product_id])
  end

  def review_params
    params.require(:review).permit(:rating, :comment)
  end
end
