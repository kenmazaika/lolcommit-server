class ReposController < ApplicationController
  before_filter :require_current_user

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
end
