class SessionsController < ApplicationController
  def create
    return render :json => auth_hash
    user = User.find_by_paypal_id(auth_hash['uid'])
    if user.blank?
      begin
        user = User.create(
          :paypal_id  => auth_hash['uid'],
          :email      => auth_hash['info']['email'],
          :first_name => auth_hash['info']['first_name'],
          :last_name  => auth_hash['info']['last_name'],
          :token      => auth_hash['credentials']['token'],
          :expires_at => auth_hash['credentials']['expires_at'],
          :expires    => auth_hash['credentials']['expires']
        )
      rescue User::ExternalServiceError
        # TODO: Airbrake this
        return redirect_to root_url, :flash => { 
          :error => 'An error occurred while creating the account' }
      end
    end

    session[:user_id] = user.id
    redirect_to root_url
  end

  def new
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
