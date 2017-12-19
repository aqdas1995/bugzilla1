require 'test_helper'

class BugsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get bugs_new_url
    assert_response :success
  end

end
