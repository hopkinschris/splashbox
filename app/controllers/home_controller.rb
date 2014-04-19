class HomeController < ApplicationController
  before_filter :get_counts, only: [:index, :show]

  def index
    @waiting = User.waiting.sort_by(&:created_at)
  end

  def show
  end

  def me
    @user = User.find_by_id(params[:id])
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
