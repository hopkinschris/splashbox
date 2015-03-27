class AddWaitlistToUsers < ActiveRecord::Migration
  def change
    add_column :users, :waitlist, :boolean, :default => true
  end
end
