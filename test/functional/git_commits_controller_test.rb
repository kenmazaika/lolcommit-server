require 'test_helper'

class GitCommitsControllerTest < ActionController::TestCase
  test "new" do
    get :new
    assert_response :success
  end
end
