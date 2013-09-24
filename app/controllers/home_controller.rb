class HomeController < ApplicationController
  def index
  end

  def show
    @user = User.find_by_id(params[:id])
  end
end
