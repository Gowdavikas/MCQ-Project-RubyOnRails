class RemoveColFromUser < ActiveRecord::Migration[7.0]
  def change
    remove_column :users, :user, :boolean
    remove_column :users, :admin, :boolean
  end
end
