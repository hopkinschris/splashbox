class RemoveDeactivatedFromUsers < ActiveRecord::Migration
  def self.up
    remove_column :users, :deactivated
  end

  def self.down
    add_column :users, :deactivated, :boolean
  end
end
