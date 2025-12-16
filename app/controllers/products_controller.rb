class ProductsController < ApplicationController
  def show
    @product = Product.find(params[:id])
    @reviews = @product.reviews.includes(:user).order(created_at: :desc)
    @review = Review.new
  end
end
