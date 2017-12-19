require 'test_helper'

class BugUserControllerTest < ActionDispatch::IntegrationTest
  test "should get assign" do
    get bug_user_assign_url
    assert_response :success
  end

end
