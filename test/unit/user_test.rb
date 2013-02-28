require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test "on user creation generate key and secret" do
    u = FactoryGirl.create(:user, :api_key => nil, :api_secret => nil)
    assert_not_nil u.api_key
    assert_not_nil u.api_secret
  end

  test "as_json doesn't return api info" do
    u = FactoryGirl.create(:user)
    json = u.as_json()

    assert_not_nil json["id"]
    assert_nil json["api_key"]
    assert_nil json["api_secret"]
  end
end
