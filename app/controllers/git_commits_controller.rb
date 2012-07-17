class GitCommitsController < ApplicationController
  before_filter :require_current_git_commit, :only => [:show]
  before_filter :require_current_user, :only => [:new, :create]
  before_filter :require_repo_if_repo_external_id_passed, :only => [:create]

  def new
    @git_commit = GitCommit.new
  end

  def create
    @git_commit = current_user.git_commits.create(params[:git_commit])

    respond_to do |format|
      if @git_commit.valid?
        format.html do
          redirect_to git_commit_path(@git_commit)
        end
        format.json do
          render :json => @git_commit
        end
      else
        format.html do
          render :new, :status => :unprocessable_entity
        end
        format.json do
          render :json => {:errors => @git_commit.errors.as_json }, :status => :unprocessable_entity
        end
      end
    end
  end

  def show
  end

  def index
    if params[:shas].blank?
      return head :bad_request
    end

    commits = GitCommit.where(:sha => params[:shas].split(','))
    render :json => commits
  end

  private
  helper_method :current_git_commit
  def current_git_commit
    @git_commit ||= GitCommit.find_by_id(params[:id])
  end

  def require_current_git_commit
    head :not_found unless current_git_commit
  end

  def require_repo_if_repo_external_id_passed
    if params[:git_commit] && params[:git_commit][:repo_external_id]
      external_id = params[:git_commit][:repo_external_id]
      repo = Repo.find_by_external_id(external_id)
      head :not_found unless repo
    end
  end
end
