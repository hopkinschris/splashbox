class HomeController < ApplicationController
  before_filter :get_counts, only: [:index, :show]
  before_filter :authenticate_user!, only: [:me]
  before_filter :correct_user?, only: [:me]

  def index
    @waiting = User.waiting.sort_by(&:created_at)
  end

  def show
  end

  def me
    @user = User.find_by_id(params[:id])
    @dropbox_photo_count = @user.completions.length
  end

  private

  def get_counts
    @user_count = User.consumers.count
    @waitlist_count = User.waiting.count

    @photo_count = 0
    User.consumers.find_each do |u|
      @photo_count += u.completions.length
    end
  end
end
