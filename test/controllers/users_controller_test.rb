require "test_helper"

class UsersControllerTest < ActionDispatch::IntegrationTest
  test "should get add_onesignal_id" do
    get users_add_onesignal_id_url
    assert_response :success
  end
end
