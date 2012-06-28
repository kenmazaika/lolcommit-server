class GitCommitsController < ApplicationController

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
end
