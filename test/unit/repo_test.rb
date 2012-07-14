require 'test_helper'

class RepoTest < ActiveSupport::TestCase

  test "before_create generate an external_id" do
    repo = Repo.new(:name => 'omg')
    assert_not_nil repo.external_id
  end
end
