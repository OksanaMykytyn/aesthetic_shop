class CategoriesController < ApplicationController
  def index
    @categories = Category
      .with_attached_photo
      .order(:name)
  end

  def show
    @category = Category.find(params[:id])

    @products = Product
      .where(category: @category, active: true)
      .includes(:reviews, images_attachments: :blob)
      .page(params[:page])
      .per(18)
  end
end
