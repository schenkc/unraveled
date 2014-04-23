class CreateLibrary < ActiveRecord::Migration
  def change
    create_table :libraries do |t|
      t.string :pattern_id
      t.string :owner_id

      t.timestamps
    end
    add_index :libraries, :pattern_id
    add_index :libraries, :owner_id
  end
end
