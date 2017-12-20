require 'test_helper'

class BugControllerTest < ActionDispatch::IntegrationTest
  test 'should get new' do
    get bug_new_url
    assert_response :success
  end
end
