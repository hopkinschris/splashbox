class RenameTumblrUrl < ActiveRecord::Migration
  def change
    rename_column :photos, :tumblr_url, :quick_url
  end
end
