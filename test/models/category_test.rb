require "test_helper"

class CategoryTest < ActiveSupport::TestCase
  test "valid category" do
    category = Category.new(name: "Одяг")
    assert category.valid?
  end

  test "name is required" do
    category = Category.new(name: "")
    assert_not category.valid?
  end

  test "name must be unique" do
    Category.create!(name: "Взуття")
    duplicate = Category.new(name: "Взуття")
    assert_not duplicate.valid?
  end

end
