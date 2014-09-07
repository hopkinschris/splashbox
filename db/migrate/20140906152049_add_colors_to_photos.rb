class AddColorsToPhotos < ActiveRecord::Migration
  def change
    add_column :photos, :colors, :text, default: []
  end
end
