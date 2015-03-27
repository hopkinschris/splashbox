class SavedToDiskToSavedToDropbox < ActiveRecord::Migration
  def change
    rename_column :photos, :saved_to_disk, :saved_to_dropbox
  end
end
