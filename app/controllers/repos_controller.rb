class ReposController < ApplicationController
  before_filter :require_current_user, :except => [:show]
  before_filter :require_current_repo, :only => :show

  def new
    @repo = Repo.new
  end

  def create
    @repo = Repo.new(params[:repo] || Hash.new)
    if @repo.valid?
      @repo.users << current_user
      @repo.save
      redirect_to repo_path(@repo)
    else
      render :new, :status => :unprocessable_entity
    end
  end

  def show
    @git_commits = current_repo.git_commits.paginate(:page => params[:page] || 1)
  end

  private
  helper_method :current_repo
  def current_repo
    @current_repo ||= Repo.find_by_id(params[:id])
  end

  def require_current_repo
    head :not_found unless current_repo
  end
end
