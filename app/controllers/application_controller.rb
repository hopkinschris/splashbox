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
      user = User.find(params[:id])
      unless current_user == user
        flash[:alert]= "Tisk, tisk, you shouldn't try to access another person's data"
        redirect_to dashboard_path id: current_user.id
      end
    rescue ActiveRecord::RecordNotFound
      flash[:alert]= "There's nothing over there"
      redirect_to dashboard_path id: current_user.id
    end
  end

  def authenticate_user!
    if !current_user
      redirect_to root_url
    end
  end
end
