class UsersController < ApplicationController
  before_filter :require_current_user, :except => :show
  before_filter :require_selected_user, :only => [:show]

  def account
  end

  def show
    respond_to do |format|
        format.json { render json: selected_user}
        format.html {
          @commits = selected_user.git_commits.order("id DESC").paginate(:page => params[:page] || 1)
        }
    end
  end

  private
  helper_method :selected_user
  def selected_user
    if params[:id].nil?
      nil
    elsif params[:id].match(/\A\d*\Z/)
      @selected_user ||= User.find_by_id(params[:id])
    else
      @selected_user ||= User.find_by_name(params[:id])
    end
  end

  def require_selected_user
    head :not_found unless selected_user
  end
end
