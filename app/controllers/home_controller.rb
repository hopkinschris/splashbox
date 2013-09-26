class HomeController < ApplicationController
  before_filter :get_photo_count, only: :show

  def index
  end

  def show
    @user = User.find_by_id(params[:id])
  end

  private

  def get_photo_count
    @count = 0
    User.all.each do |u|
      @count += u.completions.length
    end
  end
end
