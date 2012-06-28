class GitCommitsController < ApplicationController
  before_filter :require_current_git_commit, :only => [:show]

  def new
    @git_commit = GitCommit.new
  end

  def create
    @git_commit = GitCommit.create(params[:git_commit])

    if @git_commit.valid?
      redirect_to git_commit_path(@git_commit)
    else
      render :new, :status => :unprocessable_entity
    end
  end

  def show
  end

  private
  helper_method :current_git_commit
  def current_git_commit
    @git_commit ||= GitCommit.find_by_id(params[:id])
  end

  def require_current_git_commit
    head :not_found unless current_git_commit
  end
end
