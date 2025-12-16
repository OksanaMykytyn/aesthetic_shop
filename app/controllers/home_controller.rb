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
      .left_joins(:order_items)
      .group(:id)
      .order(Arel.sql("COUNT(order_items.id) DESC"))
      .limit(12)
  end
end
