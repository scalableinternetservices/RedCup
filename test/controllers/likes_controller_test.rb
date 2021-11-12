require "test_helper"

class LikesControllerTest < ActionDispatch::IntegrationTest
  test "should get click" do
    get likes_click_url
    assert_response :success
  end
end
