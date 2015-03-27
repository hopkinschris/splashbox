class RemovePhotoSavedToDropbox < ActiveRecord::Migration
  def self.up
    remove_column :photos, :saved_to_dropbox
  end

  def self.down
    add_column :photos, :saved_to_dropbox, :boolean
  end
end
