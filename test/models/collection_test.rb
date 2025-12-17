require "test_helper"

class CollectionTest < ActiveSupport::TestCase
  test "valid collection" do
    collection = Collection.new(name: "Літня колекція")
    assert collection.valid?
  end

  test "name is required" do
    collection = Collection.new
    assert_not collection.valid?
  end

  test "name must be unique" do
    Collection.create!(name: "Осінь")
    duplicate = Collection.new(name: "Осінь")
    assert_not duplicate.valid?
  end
end
