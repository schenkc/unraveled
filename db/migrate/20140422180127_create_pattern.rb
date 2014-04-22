class CreatePattern < ActiveRecord::Migration
  def change
    create_table :patterns do |t|
      t.string :name
      t.integer :designer_id
      t.string :category
      t.string :yarn_name
      t.string :yarn_weight
      t.integer :stitch_col
      t.integer :stitch_row
      t.integer :swatch
      t.string :swatch_stitch
      t.string :needles
      t.string :amount_yarn
      t.string :sizes
      t.string :price
      t.text :notes

      t.timestamps
    end

    add_index :patterns, :name
    add_index :patterns, :designer_id
    add_index :patterns, :category
  end
end
