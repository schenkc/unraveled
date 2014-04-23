class CreateLibrary < ActiveRecord::Migration
  def change
    create_table :user_liked_patterns do |t|
      t.integer :pattern_id
      t.integer :owner_id

      t.timestamps
    end
    add_index :user_liked_patterns, :pattern_id
    add_index :user_liked_patterns, :owner_id
  end
end
