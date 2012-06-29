ENV["RAILS_ENV"] = "test"
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
FakeWeb.allow_net_connect = false
require 'mocha'

class ActiveSupport::TestCase
  setup do
    AnimatedGif.any_instance.expects(:store_animation).at_least(0)
  end
end
