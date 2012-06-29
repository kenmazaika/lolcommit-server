require 'test_helper'

class AnimatedGifTest < ActiveSupport::TestCase

  setup do
    AnimatedGif.any_instance.unstub(:store_animation)
  end

  test "create from shas" do
    file = File.open("#{Rails.root}/test/fixtures/f0cbd41f2ac.jpg")
    gc = FactoryGirl.create(:git_commit)
    HTTParty.expects(:get).returns(FakeHTTPartyResponse.new(:body => file.read)) 
    gif = AnimatedGif.create(:shas => gc.sha)
    assert_not_nil gif
    assert gif.persisted?
    assert_not_nil gif.image
  end

  test "no shas" do
    gif = AnimatedGif.create(:shas => '')
    assert gif.invalid?
    assert ! gif.errors[:shas].blank?
  end

  test "no valid shas" do
    gif = AnimatedGif.create(:shas => 'omgomg')
    assert gif.invalid?
    assert ! gif.errors[:shas].blank?
  end

  test "cannot fetch images from s3" do
    file = File.open("#{Rails.root}/test/fixtures/f0cbd41f2ac.jpg")
    gc = FactoryGirl.create(:git_commit)
    HTTParty.expects(:get).returns(FakeHTTPartyResponse.new(:success => false))
    gif = AnimatedGif.create(:shas => gc.sha)
    assert ! gif.persisted?
    assert ! gif.errors[:shas].blank?
  end

  class FakeHTTPartyResponse
    attr_accessor :body, :success


    def initialize(attributes={})
      @success = true
      attributes.each do |k, v|
        self.send("#{k}=", v)
      end
    end

    def success?
      @success
    end
  end
end
