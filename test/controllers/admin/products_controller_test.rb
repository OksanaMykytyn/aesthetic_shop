require "test_helper"

class Admin::ProductsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @category = Category.create!(name: "Категорія")

    @manager = User.create!(
      first_name: "Admin",
      last_name: "User",
      email: "manager@example.com",
      password: "Strong1!",
      role: "manager"
    )

    @client = User.create!(
      first_name: "Client",
      last_name: "User",
      email: "client@example.com",
      password: "Strong1!",
      role: "client"
    )

    @product = Product.create!(
      title: "Тестовий товар",
      price_cents: 1000,
      stock: 5,
      category: @category
    )
end

  test "guest cannot access admin products" do
    get admin_products_path
    assert_redirected_to new_user_session_path
  end

  test "client cannot access admin products" do
    sign_in @client
    get admin_products_path
    assert_redirected_to root_path
  end

  test "manager can access admin products" do
    sign_in @manager
    get admin_products_path
    assert_response :success
  end

    test "manager sees product list" do
    sign_in @manager
    get admin_products_path
    assert_response :success
    assert_select "h1", "Товари"
  end

    test "manager can open new product form" do
    sign_in @manager
    get new_admin_product_path
    assert_response :success
    assert_select "h1", "Створення товару"
  end

    test "manager can create product with valid data" do
    sign_in @manager

    assert_difference("Product.count", 1) do
      post admin_products_path, params: {
        product: {
          title: "Новий товар",
          price_cents: 2000,
          stock: 10,
          category_id: @category.id,
          active: true
        }
      }
    end

    assert_redirected_to admin_products_path
  end

    test "manager cannot create product with invalid data" do
    sign_in @manager

    assert_no_difference("Product.count") do
      post admin_products_path, params: {
        product: {
          title: "",
          price_cents: -500,
          category_id: nil
        }
      }
    end

    assert_response :success
  end

    test "manager can open edit product page" do
    sign_in @manager
    get edit_admin_product_path(@product)
    assert_response :success
    assert_select "h1", "Редагування товару"
  end

    test "manager can update product" do
    sign_in @manager

    patch admin_product_path(@product), params: {
      product: { title: "Оновлений товар" }
    }

    assert_redirected_to admin_products_path
    @product.reload
    assert_equal "Оновлений товар", @product.title
  end

    test "manager can delete product" do
    sign_in @manager

    assert_difference("Product.count", -1) do
      delete admin_product_path(@product)
    end

    assert_redirected_to admin_products_path
  end
end
