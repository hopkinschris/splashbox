class AddAuthorNameAndAuthorUrlToPhotos < ActiveRecord::Migration
  def change
    add_column :photos, :author_name, :string
    add_column :photos, :author_url, :string
  end
end
