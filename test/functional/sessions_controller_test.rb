require 'test_helper'

class SessionsControllerTest < ActionController::TestCase
  setup do
    env = {
      'omniauth.auth' => {
        'uid' => '233615',
        'info' => {
          'nickname' => 'kenmazaika',
          'email'    => 'kenmazaika@gmail.com'
        },
        'credentials' => {
          'token' => 'OMG'
        }
      }
    }
    request.expects(:env).returns(env).at_least(0)
  end

  test "destroy user session" do
    user = FactoryGirl.create(:user)
    sign_in(user) 
    delete :destroy
    assert_nil session[:user_id]
  end

  test "create no user exists" do
    User.destroy_all
    assert_difference 'User.count' do
      get :create, :provider => 'github'
    end
    assert_redirected_to root_url

    user = User.last
    assert_equal user.id, session[:user_id]
    assert_equal 233615, user.github_id
    assert_equal 'kenmazaika', user.name
    assert_equal 'kenmazaika@gmail.com', user.email
    assert_equal 'OMG', user.token
  end

  test "create user exists" do
    u = FactoryGirl.create(:user, :github_id => 233615)
    
    assert_no_difference 'User.count' do
      get :create, :provider => 'github'
    end
    assert_redirected_to root_url
    assert_equal u.id, session[:user_id]
  end

end
