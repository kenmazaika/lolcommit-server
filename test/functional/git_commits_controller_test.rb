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

  test "show not found" do
    get :show, :id => 'omg'
    assert_response :not_found
  end

  test "show success" do
    gc = FactoryGirl.create(:git_commit)
    get :show, :id => gc.id
    assert_response :success
  end

  test "index no sha specified" do
    get :index
    assert_response :bad_request
  end
  test "index" do
    gc1 = FactoryGirl.create(:git_commit)
    gc2 = FactoryGirl.create(:git_commit)
    gc3 = FactoryGirl.create(:git_commit)

    get :index, :shas => [gc1.sha, gc2.sha].join(',')
    assert_equal [gc1.id, gc2.id].sort, ActiveSupport::JSON.decode(@response.body).collect{|gc| gc['id'] }.sort

  end
end
