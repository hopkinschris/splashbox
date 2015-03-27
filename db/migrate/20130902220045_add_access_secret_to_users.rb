class AddAccessSecretToUsers < ActiveRecord::Migration
  def change
    add_column :users, :access_secret, :string
  end
end
