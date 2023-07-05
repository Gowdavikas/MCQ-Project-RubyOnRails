class RemoveColUsers < ActiveRecord::Migration[7.0]
  def change
    remove_column :users, :phonenumber, :integer
  end
end
