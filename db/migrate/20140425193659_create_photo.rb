class CreatePhoto < ActiveRecord::Migration
  def change
    create_table :pictures do |t|
      t.references :imageable, polymorphic: true

      t.timestamps
    end
    add_attachment :pictures, :image
  end
end
