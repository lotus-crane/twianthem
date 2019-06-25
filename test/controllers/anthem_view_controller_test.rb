require 'test_helper'

class AnthemViewControllerTest < ActionDispatch::IntegrationTest
  test "should get anthem_view" do
    get anthem_view_anthem_view_url
    assert_response :success
  end

end
