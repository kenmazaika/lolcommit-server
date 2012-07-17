require 'test_helper'

class RepoTest < ActiveSupport::TestCase
  should validate_presence_of :name

  test "uniqueness of name" do
    repo1 = Repo.new(:name => 'omg')
    repo1.save!

    repo2 = Repo.new(:name => 'omg')
    assert repo2.invalid?
    assert ! repo2.errors[:name].blank?
  end

  test "before_create generate an external_id" do
    repo = Repo.new(:name => 'omg')
    assert_not_nil repo.external_id
  end

end
