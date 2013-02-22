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

  test "as_json" do
    repo = Repo.new(:name => 'omg')
    repo.save!
    git_commit = FactoryGirl.create(:git_commit)
    git_commit.repo = repo
    git_commit.save!

    json = repo.as_json 
    assert_not_nil json['created_at']
    assert_not_nil json['name']
    assert_not_nil json['git_commits']
  end

end
