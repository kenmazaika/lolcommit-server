class ReposController < ApplicationController
  before_filter :require_current_user

  def new
    @repo = Repo.new
  end
end
