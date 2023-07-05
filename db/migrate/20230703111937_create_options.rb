class CreateOptions < ActiveRecord::Migration[7.0]
  def change
    create_table :options do |t|
      t.string :option_1
      t.string :option_2
      t.string :option_3
      t.string :option_4
      t.references :question, null: false, foreign_key: true

      t.timestamps
    end
  end
end
