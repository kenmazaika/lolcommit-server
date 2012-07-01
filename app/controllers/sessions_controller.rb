class SessionsController < ApplicationController
  def create
    user = User.find_by_github_id(auth_hash['uid'])
    if user.blank?
      user = User.create(
        :github_id  => auth_hash['uid'],
        :email      => auth_hash['info']['email'],
        :name       => auth_hash['info']['nickname'],
        :token      => auth_hash['credentials']['token'],
      )
    end

    session[:user_id] = user.id
    redirect_to root_url
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url
  end

private

  def auth_hash
    request.env['omniauth.auth']
  end
end
