class CheckoutsController < ApplicationController
  include CurrentCart
  before_action :authenticate_user!

  def show
    @cart = @current_cart
    @items = @cart.cart_items.includes(:product)
    redirect_to cart_path, alert: "Кошик порожній" if @items.empty?
  end

  def create
    cart = @current_cart

    order = current_user.orders.build(order_params)
    order.status = "new_order"
    order.number = generate_order_number
    order.total_cents = calculate_total(cart)

    if order.save
      cart.cart_items.each do |item|
        order.order_items.create!(
          product: item.product,
          quantity: item.quantity,
          unit_price_cents: item.product.price_cents,
          total_price_cents: item.product.price_cents * item.quantity,
          product_title: item.product.title
        )
      end

      cart.update(status: "completed")
      current_user.carts.create!(status: "active")

      if order.payment_method == "online"
  items = cart.cart_items.to_a

cart.update(status: "completed")
current_user.carts.create!(status: "active")

session = Stripe::Checkout::Session.create(
  line_items: items.map do |item|
    {
      price_data: {
        currency: "uah",
        product_data: { name: item.product.title },
        unit_amount: item.product.price_cents
      },
      quantity: item.quantity
    }
  end,
  mode: "payment",
  success_url: orders_url,
  cancel_url: checkout_url
)


  redirect_to session.url, allow_other_host: true
else
  redirect_to orders_path, notice: "Замовлення оформлено"
end


    else
      @cart = cart
      @items = cart.cart_items.includes(:product)
      render :show, status: :unprocessable_entity
    end
  end

  private

  def order_params
    params.require(:order).permit(
      :payment_method,
      :shipping_method,
      :notes,
      shipping_address: {},
      billing_address: {}
    )
  end

  def calculate_total(cart)
    cart.cart_items.sum { |i| i.product.price_cents * i.quantity }
  end

  def generate_order_number
    "ORD-#{Time.current.strftime('%Y%m%d')}-#{SecureRandom.hex(3).upcase}"
  end
end
