module CurrentCart
  extend ActiveSupport::Concern

  included do
    before_action :set_current_cart
  end

  private

  def set_current_cart
    if user_signed_in?
      @current_cart = current_user.carts.find_or_create_by(status: "active")
      merge_session_cart
    else
      session[:cart] ||= {}
      @current_cart = session[:cart]
    end
  end

  def merge_session_cart
    return unless session[:cart].present?

    session[:cart].each do |product_id, quantity|
      product = Product.find_by(id: product_id)
      next unless product

      item = @current_cart.cart_items.find_or_initialize_by(product: product)
      item.quantity ||= 0
      item.quantity += quantity.to_i
      item.save
    end

    session[:cart] = nil
  end
end
