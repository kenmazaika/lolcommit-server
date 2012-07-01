require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test "on user creation generate key and secret" do
    u = FactoryGirl.create(:user, :api_key => nil, :api_secret => nil)
    assert_not_nil u.api_key
    assert_not_nil u.api_secret
  end
end
