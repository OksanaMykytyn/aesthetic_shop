require "test_helper"

class UserTest < ActiveSupport::TestCase
  def valid_user
    User.new(
      first_name: "Оксана",
      last_name: "Микитин",
      email: "oksana@example.com",
      password: "Strong1!",
      role: "client"
    )
  end

  test "user is valid with correct data" do
    user = valid_user
    assert user.valid?
  end

  test "first_name is required" do
    user = valid_user
    user.first_name = ""
    assert_not user.valid?
    assert_includes user.errors[:first_name], "Обов'язкове поле."
  end

  test "last_name must contain only letters" do
    user = valid_user
    user.last_name = "1234"
    assert_not user.valid?
  end

  test "password must be strong" do
    user = valid_user
    user.password = "12345678"
    assert_not user.valid?
  end

  test "password length must be between 8 and 20" do
    user = valid_user
    user.password = "Aa1!"
    assert_not user.valid?
  end
end
