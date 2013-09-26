class AddCompletionsToUser < ActiveRecord::Migration
  def change
    add_column :users, :completions, :text
  end
end
