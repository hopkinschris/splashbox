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
    result = request_token.get_access_token(oauth_verifier: params[:oauth_token])
    create_user_and_return_home(result)
  end

  def create_user_and_return_home(result)
    if user = User.find_by_name(params[:uid])
      user.update_attributes(access_token: result.token, access_secret: result.secret)
      flash[:notice] = "You already have an account :)"
      redirect_to controller: 'home', action: 'show', new_user: false
    else
      user = User.create(access_token: result.token, access_secret: result.secret, name: params[:uid])
      flash[:notice] = "Beauty! You've succesfully authorized Splashbox."
      redirect_to controller: 'home', action: 'show', new_user: true
    end
  end
end
