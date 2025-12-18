class CatalogController < ApplicationController
  def index
    @categories  = Category.all
    @collections = Collection.all

    products = Product
      .includes(:category, :collections)
      .where(active: true)

    if params[:query].present?
      products = products.where("products.title ILIKE ?", "%#{params[:query]}%")
    end

    if params[:categories].present?
      products = products.where(category_id: params[:categories])
    end

    if params[:collections].present?
      products = products
        .joins(:collections)
        .where(collections: { id: params[:collections] })
    end

    if params[:price_from].present?
      products = products.where("price_cents >= ?", params[:price_from].to_i * 100)
    end

    if params[:price_to].present?
      products = products.where("price_cents <= ?", params[:price_to].to_i * 100)
    end

    if params[:ratings].present?
      products = products.where(rating_avg: params[:ratings].map(&:to_i))
    end

    products = products.order(sort_order)

    @products = products.distinct.page(params[:page]).per(18)
  end

  private

  def sort_order
    case params[:sort]
    when "price_asc"
      "price_cents ASC"
    when "price_desc"
      "price_cents DESC"
    when "rating_desc"
      "rating_avg DESC NULLS LAST"
    when "newest"
      "created_at DESC"
    else
      "created_at DESC"
    end
  end
end
