require 'test_helper'

class CommentsControllerTest < ActionController::TestCase
  test "should get comment:text" do
    get :comment:text
    assert_response :success
  end

end
