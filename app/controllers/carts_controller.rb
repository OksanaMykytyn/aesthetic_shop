class CartsController < ApplicationController
  include CurrentCart

  def show
    if user_signed_in?
      @items = @current_cart.cart_items.includes(:product)
    else
      @items = Product.find(@current_cart.keys).map do |product|
        OpenStruct.new(
          product: product,
          quantity: @current_cart[product.id.to_s]
        )
      end
    end
  end
end
