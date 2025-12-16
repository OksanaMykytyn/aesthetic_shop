class CatalogController < ApplicationController
  def index
    @categories  = Category.all
    @collections = Collection.all

    is_filtered = params.except(:controller, :action, :page, :commit).present?

    products = Product
      .includes(:category, :collections, :reviews)
      .references(:category, :collections)


    if params[:query].present?
      products = products.where("products.title ILIKE ?", "%#{params[:query]}%")
    end

    if params[:categories].present?
      products = products.where(category_id: params[:categories])
    end

    if params[:collections].present?
      products = products.joins(:collections)
                         .where(collections: { id: params[:collections] })
    end

    if params[:price_from].present?
      products = products.where("price_cents >= ?", params[:price_from].to_i * 100)
    end

    if params[:price_to].present?
      products = products.where("price_cents <= ?", params[:price_to].to_i * 100)
    end

    if params[:ratings].present?
      products = products
        .left_joins(:reviews)
        .group("products.id")
        .having("AVG(reviews.rating) IN (?)", params[:ratings].map(&:to_i))
    end

    current_page = if is_filtered
                     1 
                   else
                     params[:page]
                   end
    
    @products = products.select("products.*").distinct.page(current_page).per(18)
  end
end