require 'test_helper'

class GitCommitTest < ActiveSupport::TestCase
  test "validations" do
    commit = FactoryGirl.create(:git_commit)

    commit = GitCommit.new
    assert ! commit.valid?
    assert ! commit.errors[:repo].blank?
    assert ! commit.errors[:sha].blank?
  end
end
