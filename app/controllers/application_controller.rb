class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  private

  def current_user
    begin
      @current_user ||= User.find session[:user_id] if session[:user_id]
    rescue ActiveRecord::RecordNotFound
      nil
    end
  end

  def correct_user?
    begin
      @user = User.find(session[:user_id])
      unless current_user == @user
        flash[:alert]= "Tisk, tisk, you shouldn't try to access another person's data"
        redirect_to dashboard_path
      end
    rescue ActiveRecord::RecordNotFound
      flash[:alert]= "There's nothing over there"
      redirect_to dashboard_path
    end
  end

  def authenticate_user!
    if !current_user
      flash[:alert] = "You must authenticate first to view your dashboard."
      redirect_to root_url
    end
  end
end
