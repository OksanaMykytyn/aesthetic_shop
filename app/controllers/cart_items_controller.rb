class CartItemsController < ApplicationController
  include CurrentCart

  def create
  product = Product.find(params[:product_id])

  if user_signed_in?
    item = @current_cart.cart_items.find_or_initialize_by(product: product)
    item.quantity ||= 0
    item.quantity += 1
    item.save
  else
    key = product.id.to_s
    @current_cart[key] = (@current_cart[key] || 0) + 1
    session[:cart] = @current_cart
  end

  redirect_to cart_path
end


  def update
    if user_signed_in?
      item = CartItem.find(params[:id])
      item.update(quantity: params[:quantity])
    else
      session[:cart][params[:id]] = params[:quantity].to_i
    end

    redirect_to cart_path
  end

  def destroy
    if user_signed_in?
      CartItem.find(params[:id]).destroy
    else
      session[:cart].delete(params[:id])
    end

    redirect_to cart_path
  end
end
