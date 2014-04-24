class CreateTags < ActiveRecord::Migration
  def change
    create_table :tags do |t|
      t.string :name

      t.timestamps
    end

    create_table :pattern_tags do |t|
      t.integer :tag_id
      t.integer :pattern_id

      t.timestamps
    end
  end
end
