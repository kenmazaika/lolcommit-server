ENV["RAILS_ENV"] = "test"
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
FakeWeb.allow_net_connect = false
require 'mocha/setup'

class ActiveSupport::TestCase
  setup do
    AnimatedGif.any_instance.expects(:store_animation).at_least(0)
  end
end

class ActionController::TestCase
  def sign_in(user)
    session[:user_id] = user.id
  end

  def setup_bogus_controller_routes!
    begin
      _routes = Rails.application.routes
      _routes.disable_clear_and_finalize = true
      _routes.clear!
      Rails.application.routes_reloader.paths.each{ |path| load(path) }
      _routes.draw do
        match '/:controller(/:action(/:id))', via: [:get, :post]
      end
      ActiveSupport.on_load(:action_controller) { _routes.finalize! }
    ensure
      _routes.disable_clear_and_finalize = false
    end
  end

  def teardown_bogus_controller_routes!
    Rails.application.reload_routes!
  end 

  def json_resp
    ActiveSupport::JSON.decode(@response.body)
  end
  
end
