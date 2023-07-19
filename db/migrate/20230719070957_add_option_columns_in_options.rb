class AddOptionColumnsInOptions < ActiveRecord::Migration[7.0]
  def change
    add_column :options, :option, :string
  end
end
