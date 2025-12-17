require "test_helper"

class UserRegistrationTest < ActionDispatch::IntegrationTest
  test "user can register with valid data" do
    assert_difference("User.count", 1) do
      post user_registration_path, params: {
        user: {
          first_name: "Оксана",
          last_name: "Микитин",
          email: "newuser@example.com",
          password: "Strong1!",
          password_confirmation: "Strong1!"
        }
      }
    end

    follow_redirect!
    assert_response :success
  end

  test "user cannot register with invalid password" do
    assert_no_difference("User.count") do
      post user_registration_path, params: {
        user: {
          first_name: "Оксана",
          last_name: "Микитин",
          email: "badpass@example.com",
          password: "123456",
          password_confirmation: "123456"
        }
      }
    end

    assert_response :unprocessable_entity
  end
end
