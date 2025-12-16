class CollectionsController < ApplicationController
  def index
    @collections = Collection
      .with_attached_photo
      .order(:name)
  end

   def show
    @collection = Collection.find(params[:id])

    @products = Product
      .joins(:collections)
      .where(collections: { id: @collection.id }, active: true)
      .includes(:reviews, images_attachments: :blob)
      .distinct
      .page(params[:page])
      .per(18)
  end
end
