require 'test_helper'

class TestController < ApplicationController
  before_filter :require_current_user, :only => :get_current_user
  def get_current_user
    render :json => current_user
  end
end

class ApplicationControllerTest < ActionController::TestCase
  setup :setup_bogus_controller_routes!
  teardown  :teardown_bogus_controller_routes!
  self.controller_class = TestController

  test "current_user by session" do
    user = FactoryGirl.create(:user)
    sign_in user
    get :get_current_user
    assert_equal user.id, json_resp['id']
  end

  test "current_user by api key" do
    user = FactoryGirl.create(:user) 
    t = Time.now.to_i.to_s
    get :get_current_user, :key => user.api_key,
      :t => t,
      :token =>  Digest::SHA1.hexdigest(user.api_secret + t)
    assert_response :success
    assert_equal user.id, json_resp['id']
  end

  test "require current_user" do
    get :get_current_user
    assert_redirected_to auth_github_url
  end

  test "require_current_user json" do
    get :get_current_user, :format => :json
    assert_response :unauthorized
  end

  test "api credentials not good" do
    user = FactoryGirl.create(:user) 
    get :get_current_user, :key => user.api_key,
      :t => "OMG",
      :token =>  Digest::SHA1.hexdigest(user.api_secret + "LOL")
    assert_response :unauthorized
  end

  test "api credentials cannot find user" do
    get :get_current_user, :key => "OMG",
      :t => "OMG",
      :token =>  Digest::SHA1.hexdigest("LOL")
    assert_response :unauthorized
  end

end
