require "test_helper"

class Admin::CollectionsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @manager = User.create!(
      first_name: "Admin",
      last_name: "User",
      email: "manager_col@example.com",
      password: "Strong1!",
      role: "manager"
    )

    @collection = Collection.create!(name: "Зима")
  end

    test "guest cannot access collections" do
    get admin_collections_path
    assert_redirected_to new_user_session_path
  end

  test "manager can access collections" do
    sign_in @manager
    get admin_collections_path
    assert_response :success
  end

    test "manager can create collection" do
    sign_in @manager

    assert_difference("Collection.count", 1) do
      post admin_collections_path, params: {
        collection: { name: "Весна" }
      }
    end

    assert_redirected_to admin_collections_path
  end

    test "manager can update collection" do
    sign_in @manager

    patch admin_collection_path(@collection), params: {
      collection: { name: "Оновлена колекція" }
    }

    @collection.reload
    assert_equal "Оновлена колекція", @collection.name
  end

    test "manager can delete collection" do
    sign_in @manager

    assert_difference("Collection.count", -1) do
      delete admin_collection_path(@collection)
    end
  end
end
