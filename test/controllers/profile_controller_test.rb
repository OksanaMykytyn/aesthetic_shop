require "test_helper"

class ProfileControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = User.create!(
      first_name: "Оксана",
      last_name: "Микитин",
      email: "profile@example.com",
      password: "Strong1!",
      role: "client"
    )
  end

  test "redirects guest user" do
    get profile_path
    assert_redirected_to new_user_session_path
  end

  test "shows profile for logged in user" do
    sign_in @user
    get profile_path
    assert_response :success
    assert_select "h1", text: "#{@user.first_name} #{@user.last_name}"
  end
end
