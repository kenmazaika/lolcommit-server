require 'test_helper'

class GitCommitsControllerTest < ActionController::TestCase
  test "new" do
    get :new
    assert_response :success
  end

  test "create failure" do
    assert_no_difference 'GitCommit.count' do
      post :create, :git_commit => {}
    end
    assert_response :unprocessable_entity
  end

  test "create success" do
    assert_difference 'GitCommit.count' do
      post :create, :git_commit => {
        :sha => 'sss',
        :repo => 'omg'
      }
    end
    gc = GitCommit.last
    assert_redirected_to git_commit_path(gc)
  end
end
