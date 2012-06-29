require 'test_helper'

class AnimatedGifTest < ActiveSupport::TestCase
  test "create from shas" do
    image_url = 'http://omg.com/image'
    file = File.open("#{Rails.root}/test/fixtures/f0cbd41f2ac.jpg")
    gc = FactoryGirl.create(:git_commit)
    HTTParty.expects(:get).returns(FakeHTTPartyResponse.new(:body => file.read)) 
    gif = AnimatedGif.create(:shas => gc.sha)
    assert_not_nil gif
    assert gif.persisted?
    assert_not_nil gif.image
  end

  class FakeHTTPartyResponse
    attr_accessor :body

    def initialize(attributes={})
      attributes.each do |k, v|
        self.send("#{k}=", v)
      end
    end

    def success?
      true
    end
  end
end
