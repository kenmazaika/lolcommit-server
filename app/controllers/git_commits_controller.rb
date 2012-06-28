class GitCommitsController < ApplicationController

  def new
    @git_commit = GitCommit.new
  end
end
