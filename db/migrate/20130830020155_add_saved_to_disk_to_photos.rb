class AddSavedToDiskToPhotos < ActiveRecord::Migration
  def change
    add_column :photos, :saved_to_disk, :boolean, :default => false
  end
end
