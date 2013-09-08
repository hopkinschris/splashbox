class AddEmailAndDropboxUidToUsers < ActiveRecord::Migration
  def change
    add_column :users, :email, :string
    add_column :users, :dropbox_uid, :string
  end
end
