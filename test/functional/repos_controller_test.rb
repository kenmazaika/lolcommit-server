require 'test_helper'

class ReposControllerTest < ActionController::TestCase

  test "new not logged in" do
    get :new
    assert_redirected_to auth_github_url
  end

  test "new logged in" do
    sign_in FactoryGirl.create(:user)
    get :new
    assert_response :success
  end
end
