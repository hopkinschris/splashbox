class AddTumblrUrlToPhotos < ActiveRecord::Migration
  def change
    add_column :photos, :tumblr_url, :string
  end
end
