require 'test_helper'

class GitCommitTest < ActiveSupport::TestCase
  test "validations" do
    commit = FactoryGirl.create(:git_commit)

    commit = GitCommit.new
    assert ! commit.valid?
    assert ! commit.errors[:sha].blank?
  end

  test "repo_external_id setter" do
    user1 = FactoryGirl.create(:user)
    user2 = FactoryGirl.create(:user)
    repo = FactoryGirl.create(:repo, :users => [user1])
    commit = FactoryGirl.build(:git_commit, :user => user2, :repo_external_id => repo.external_id )

    assert_equal repo, commit.repo
    repo.reload
    assert_equal [user1, user2], repo.users
  end
end
