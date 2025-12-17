require "test_helper"

class Admin::CategoriesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @manager = User.create!(
      first_name: "Admin",
      last_name: "User",
      email: "manager_cat@example.com",
      password: "Strong1!",
      role: "manager"
    )

    @client = User.create!(
      first_name: "Client",
      last_name: "User",
      email: "client_cat@example.com",
      password: "Strong1!",
      role: "client"
    )

    @category = Category.create!(name: "Одяг")
  end

    test "guest cannot access categories" do
    get admin_categories_path
    assert_redirected_to new_user_session_path
  end

  test "client cannot access categories" do
    sign_in @client
    get admin_categories_path
    assert_redirected_to root_path
  end

  test "manager can access categories" do
    sign_in @manager
    get admin_categories_path
    assert_response :success
  end

    test "manager sees categories list" do
    sign_in @manager
    get admin_categories_path
    assert_select "h1", /Категор/
  end

    test "manager can create category" do
    sign_in @manager

    assert_difference("Category.count", 1) do
      post admin_categories_path, params: {
        category: { name: "Взуття" }
      }
    end

    assert_redirected_to admin_categories_path
  end

  test "manager cannot create invalid category" do
    sign_in @manager

    assert_no_difference("Category.count") do
      post admin_categories_path, params: {
        category: { name: "" }
      }
    end
  end

    test "manager can update category" do
    sign_in @manager

    patch admin_category_path(@category), params: {
      category: { name: "Оновлена категорія" }
    }

    assert_redirected_to admin_categories_path
    @category.reload
    assert_equal "Оновлена категорія", @category.name
  end

    test "manager can delete empty category" do
    sign_in @manager

    assert_difference("Category.count", -1) do
      delete admin_category_path(@category)
    end
  end

end

