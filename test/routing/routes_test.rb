require "test_helper"

class RoutesTest < ActionDispatch::IntegrationTest

  test "root route" do
    assert_routing "/", controller: "home", action: "index"
  end

  test "devise login route" do
    assert_routing "/users/sign_in",
      controller: "users/sessions",
      action: "new"
  end

  test "devise logout route" do
    assert_routing(
      { path: "/users/sign_out", method: :delete },
      controller: "users/sessions",
      action: "destroy"
    )
  end

  test "catalog index" do
    assert_routing "/catalog",
      controller: "catalog",
      action: "index"
  end

  test "product show" do
    assert_routing "/products/1",
      controller: "products",
      action: "show",
      id: "1"
  end

  test "create review for product" do
    assert_routing(
      { path: "/products/1/reviews", method: :post },
      controller: "reviews",
      action: "create",
      product_id: "1"
    )
  end

  test "profile show" do
    assert_routing "/profile",
      controller: "profiles",
      action: "show"
  end

  test "checkout show" do
    assert_routing "/checkout",
      controller: "checkouts",
      action: "show"
  end

  test "checkout create" do
    assert_routing(
      { path: "/checkout", method: :post },
      controller: "checkouts",
      action: "create"
    )
  end

  test "orders index" do
    assert_routing "/orders",
      controller: "orders",
      action: "index"
  end

  test "orders show" do
    assert_routing "/orders/1",
      controller: "orders",
      action: "show",
      id: "1"
  end

  test "categories index" do
    assert_routing "/categories",
      controller: "categories",
      action: "index"
  end

  test "categories show" do
    assert_routing "/categories/1",
      controller: "categories",
      action: "show",
      id: "1"
  end

  test "collections index" do
    assert_routing "/collections",
      controller: "collections",
      action: "index"
  end

  test "collections show" do
    assert_routing "/collections/1",
      controller: "collections",
      action: "show",
      id: "1"
  end

  test "cart show" do
    assert_routing "/cart",
      controller: "carts",
      action: "show"
  end

  test "cart add item" do
    assert_routing(
      { path: "/cart/add/5", method: :post },
      controller: "cart_items",
      action: "create",
      product_id: "5"
    )
  end

  test "cart update item" do
    assert_routing(
      { path: "/cart/update/3", method: :patch },
      controller: "cart_items",
      action: "update",
      id: "3"
    )
  end

  test "cart remove item" do
    assert_routing(
      { path: "/cart/remove/3", method: :delete },
      controller: "cart_items",
      action: "destroy",
      id: "3"
    )
  end

  test "admin root" do
    assert_routing "/admin",
      controller: "admin/dashboard",
      action: "show"
  end

  test "admin categories index" do
    assert_routing "/admin/categories",
      controller: "admin/categories",
      action: "index"
  end

  test "admin categories show" do
    assert_routing "/admin/categories/1",
      controller: "admin/categories",
      action: "show",
      id: "1"
  end

  test "admin collections index" do
    assert_routing "/admin/collections",
      controller: "admin/collections",
      action: "index"
  end

  test "admin products index" do
    assert_routing "/admin/products",
      controller: "admin/products",
      action: "index"
  end

  test "admin products new" do
    assert_routing "/admin/products/new",
      controller: "admin/products",
      action: "new"
  end

  test "admin products edit" do
    assert_routing "/admin/products/1/edit",
      controller: "admin/products",
      action: "edit",
      id: "1"
  end

  test "admin reviews index" do
    assert_routing "/admin/reviews",
      controller: "admin/reviews",
      action: "index"
  end

  test "admin reviews destroy" do
    assert_routing(
      { path: "/admin/reviews/1", method: :delete },
      controller: "admin/reviews",
      action: "destroy",
      id: "1"
    )
  end

  test "admin orders index" do
    assert_routing "/admin/orders",
      controller: "admin/orders",
      action: "index"
  end

  test "admin orders show" do
    assert_routing "/admin/orders/1",
      controller: "admin/orders",
      action: "show",
      id: "1"
  end

  test "admin orders update" do
    assert_routing(
      { path: "/admin/orders/1", method: :patch },
      controller: "admin/orders",
      action: "update",
      id: "1"
    )
  end
end
