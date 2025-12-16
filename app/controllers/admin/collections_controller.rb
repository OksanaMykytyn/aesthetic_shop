class Admin::CollectionsController < ApplicationController
  before_action :authenticate_user!
  before_action :require_admin!
  before_action :set_collection, only: %i[edit update destroy]

  def index
    @collections = Collection.includes(:products)
  end

  def new
    @collection = Collection.new
    @products = Product.all
  end

  def create
    @collection = Collection.new(collection_params)

    if @collection.save
      redirect_to admin_collections_path, notice: "Колекцію створено"
    else
      @products = Product.all
      render :new
    end
  end

  def edit
    @products = Product.all
  end

  def update
    if @collection.update(collection_params)
      redirect_to admin_collections_path, notice: "Колекцію оновлено"
    else
      @products = Product.all
      render :edit
    end
  end

  def destroy
    @collection.destroy
    redirect_to admin_collections_path, notice: "Колекцію видалено"
  end

  private

  def set_collection
    @collection = Collection.find(params[:id])
  end

  def collection_params
    params.require(:collection)
          .permit(:name, :description, :photo, product_ids: [])
  end

  def require_admin!
    redirect_to root_path unless current_user.role == "manager"
  end
end
