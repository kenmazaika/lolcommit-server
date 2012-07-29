require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  test "account" do
    sign_in FactoryGirl.create(:user)
    get :account
    assert_response :success
  end
end
