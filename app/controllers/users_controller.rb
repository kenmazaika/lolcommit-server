class UsersController < ApplicationController
  before_filter :require_current_user

  def account
  end
end
