class DropboxController < ApplicationController

  def authorize
    consumer = Dropbox::API::OAuth.consumer(:authorize)
    request_token = consumer.get_request_token
    session[:request_token] = request_token.token
    session[:request_token_secret] = request_token.secret
    redirect_to request_token.authorize_url(oauth_callback: callback_url)
  end

  def authorized_callback
    consumer = Dropbox::API::OAuth.consumer(:authorize)
    request_token = OAuth::RequestToken.new(consumer, session[:request_token], session[:request_token_secret])
    if params[:not_approved] == "true"
      flash[:error] = "Oops! Looks like you didn't complete authentication with Dropbox."
      redirect_to root_url
    else
      result = request_token.get_access_token(oauth_verifier: params[:oauth_token])
      create_user_and_return_home(result)
    end
  end

  def create_user_and_return_home(result)
    if user = User.find_by_dropbox_uid(params[:uid])
      user.update_attributes(access_token: result.token, access_secret: result.secret)
      session[:user_id] = user.id

      if user.waitlist?
        flash[:notice] = "You're still on the waitlist. Please be patient :)"
      else
        if user.donater?
          flash[:notice] = "Welcome back :)"
        else
          flash[:notice] = "Enjoy Splashbox? Please consider making a $1 monthly donation, it would mean a lot!"
        end
      end
      redirect_to dashboard_path
    else
      user = User.create!(access_token: result.token, access_secret: result.secret, dropbox_uid: params[:uid])
      session[:user_id] = user.id

      flash[:notice] = "Beauty! Successfully connected Splashbox with Dropbox. You're now on the waitlist."
      redirect_to dashboard_path
    end
  end

  def destroy
    reset_session
    flash[:notice] = "Logged out. Come back soon!"
    redirect_to root_url
  end
end
