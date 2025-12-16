class Admin::ProductsController < ApplicationController
  before_action :authenticate_user!
  before_action :require_admin!
  before_action :set_product, only: %i[edit update destroy]

  def index
    @products = Product
      .includes(:category, :collections, images_attachments: :blob)
      .order(created_at: :desc)
      .page(params[:page])
      .per(12)
  end

  def new
    @product = Product.new
    load_dependencies
  end

  def create
    @product = Product.new(product_params)

    if @product.save
      redirect_to admin_products_path, notice: "Товар створено"
    else
      load_dependencies
      render :new
    end
  end

  def edit
    load_dependencies
  end

  def update
    if @product.update(product_params)
      redirect_to admin_products_path, notice: "Товар оновлено"
    else
      load_dependencies
      render :edit
    end
  end

  def destroy
    @product.destroy
    redirect_to admin_products_path, notice: "Товар видалено"
  end

  private

  def set_product
    @product = Product.find(params[:id])
  end

  def load_dependencies
    @categories = Category.all
    @collections = Collection.all
  end

  def product_params
    params.require(:product).permit(
      :title,
      :description,
      :price_cents,
      :stock,
      :category_id,
      :active,
      images: [],
      collection_ids: []
    )
  end

  def require_admin!
    redirect_to root_path unless current_user.role == "manager"
  end
end
