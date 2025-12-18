class HomeController < ApplicationController
  def index
    @popular_categories = Category
      .left_joins(:products)
      .group(:id)
      .order(Arel.sql("COUNT(products.id) DESC"))
      .limit(4)

    @popular_collections = Collection
      .left_joins(:products)
      .group(:id)
      .order(Arel.sql("COUNT(products.id) DESC"))
      .limit(4)
    
    @popular_products = Product
  .where(active: true)
  .order(created_at: :desc)
  .limit(12)

  end
end
