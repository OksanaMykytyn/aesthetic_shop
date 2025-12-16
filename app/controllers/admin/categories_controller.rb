class Admin::CategoriesController < ApplicationController
  before_action :authenticate_user!
  before_action :require_admin!
  before_action :set_category, only: %i[edit update destroy]

  def index
    @categories = Category.includes(:products)
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)

    if @category.save
      redirect_to admin_categories_path, notice: "Категорію створено"
    else
      render :new
    end
  end

  def edit
    @products = Product.all
  end

  def update
    if @category.update(category_params)
      redirect_to admin_categories_path, notice: "Категорію оновлено"
    else
      @products = Product.all
      render :edit
    end
  end

  def destroy
    if @category.destroy
      redirect_to admin_categories_path, notice: "Категорію видалено"
    else
      redirect_to admin_categories_path,
        alert: "Неможливо видалити категорію з товарами"
    end
  end

  private

  def set_category
    @category = Category.find(params[:id])
  end

  def category_params
    params.require(:category)
      .permit(:name, :description, :photo, product_ids: [])
  end

  def require_admin!
    redirect_to root_path unless current_user.role == "manager"
  end
end
