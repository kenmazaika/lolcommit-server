class UsersController < ApplicationController
  before_filter :require_current_user, :except => :show
  before_filter :require_selected_user, :only => [:show]

  def account
  end

  def show
    @commits = selected_user.git_commits.order("id DESC").paginate(:page => params[:page] || 1)
  end

  private
  helper_method :selected_user
  def selected_user
    @selected_user ||= User.find_by_id(params[:id])
  end

  def require_selected_user
    head :not_found unless selected_user
  end
end
