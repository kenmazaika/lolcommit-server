require 'test_helper'

class AnimatedGifsControllerTest < ActionController::TestCase
  test "create validation error" do
    assert_no_difference 'AnimatedGif.count' do
      post :create, :animated_gif => {}
    end

    assert_response :unprocessable_entity
    assert ! parsed_response['errors'].blank?
  end

  test "create success" do
    gc = FactoryGirl.create(:git_commit)
    assert_difference 'AnimatedGif.count' do
      post :create, :animated_gif => {:shas => gc.sha}
    end
    assert_response :success
    ag = AnimatedGif.last
    assert_equal ag.id, parsed_response['id']
  end

  def parsed_response
    ActiveSupport::JSON.decode(@response.body)
  end
end
