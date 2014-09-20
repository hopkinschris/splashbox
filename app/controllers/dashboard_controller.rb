class DashboardController < ApplicationController
  before_filter :authenticate_user!
  before_filter :correct_user?
  before_filter :get_photos, only: :index

  def index
    @waiters = User.waiters.sort_by(&:created_at)
  end

  private

  def get_photos
    @photos = []
    current_user.completions.each do |source_url|
      if photo = Photo.find_by_source_url(source_url)
        @photos << photo
      end
    end

    @photos.sort!{ |a,b| b.created_at <=> a.created_at }
  end
end
