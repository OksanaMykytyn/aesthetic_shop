require "test_helper"

class ProductTest < ActiveSupport::TestCase
  setup do
    @category = Category.create!(name: "Категорія")
  end

  def valid_product
    Product.new(
      title: "Футболка",
      price_cents: 1500,
      stock: 10,
      category: @category,
      active: true
    )
  end

  test "product is valid with correct data" do
    product = valid_product
    assert product.valid?
  end

  test "title is required" do
    product = valid_product
    product.title = nil
    assert_not product.valid?
  end

  test "price_cents must be >= 0" do
    product = valid_product
    product.price_cents = -100
    assert_not product.valid?
  end

  test "product must belong to category" do
    product = valid_product
    product.category = nil
    assert_not product.valid?
  end
end
