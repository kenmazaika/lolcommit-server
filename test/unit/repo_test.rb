require 'test_helper'

class RepoTest < ActiveSupport::TestCase
  test "find_or_create_by_username_and_name" do
    repo = nil
    assert_difference 'Repo.count' do
      repo = Repo.find_or_create_by_username_and_name('kenmazaika', 'lolcommit-server')
    end
    assert_equal 'kenmazaika', repo.username
    assert_equal 'lolcommit-server', repo.name

    repo2 = nil
    assert_no_difference 'Repo.count' do
      repo2 = Repo.find_or_create_by_username_and_name('kenmazaika', 'lolcommit-server')
    end
    
    assert_equal repo, repo2
  end
end
