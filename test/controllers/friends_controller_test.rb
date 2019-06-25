require 'test_helper'

class FriendsControllerTest < ActionDispatch::IntegrationTest
  test "should get regist" do
    get friends_regist_url
    assert_response :success
  end

end
