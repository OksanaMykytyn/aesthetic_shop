require "test_helper"

class OrderTest < ActiveSupport::TestCase
  test "order is invalid without number" do
    order = Order.new

    assert_not order.valid?
    assert order.errors[:number].present?
  end
end
