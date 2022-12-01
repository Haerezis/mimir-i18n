require "test_helper"

class Api::V1::CurrentUserControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = create(:user)
  end

  test "not signed in" do
    get api_v1_current_user_path
    assert_response :unauthorized
  end

  test "signed in" do
    sign_in(@user)
    get api_v1_current_user_path
    assert_response :success

    json = JSON.parse(response.body)
    assert_equal @user.id, json['id']
  end
end
