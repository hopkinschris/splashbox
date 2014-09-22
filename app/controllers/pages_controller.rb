class PagesController < ApplicationController
  before_filter :get_counts, only: :marketing

  def marketing
  end

  private

  def get_counts
    @user_count    = 0
    @photo_count   = 0
    @payload_count = Photo.count

    User.find_each do |u|
      if u.consumer?
        @user_count  += 1
        @photo_count += u.completions.length
      end
    end
  end
end
