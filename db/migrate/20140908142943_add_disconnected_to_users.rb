class AddDisconnectedToUsers < ActiveRecord::Migration
  def change
    add_column :users, :disconnected, :boolean, default: false
  end
end
