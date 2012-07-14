class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :validate_api_credentials_good

  private

  def validate_api_credentials_good
    if ! params[:key].blank?
      t = params[:t]
      token = params[:token]

      user = User.find_by_api_key(params[:key])
      if user.blank? || Digest::SHA1.hexdigest(user.api_secret + t) != token
        render :json => {:error => 'Invalid Token' }, :status => :unauthorized
      end
    end
  end

  def require_current_user
    redirect_to auth_github_url if current_user.blank? && params[:format] != 'json'
    render :json => {:error => "Invalid Authentication"}, :status => :unauthorized if current_user.blank? && params[:format] == 'json'
  end

  helper_method :current_user
  def current_user
    if session[:user_id]
      User.find_by_id(session[:user_id])
    elsif ! params[:key].blank?
      User.find_by_api_key(params[:key])
    else
      nil
    end
  end
end
