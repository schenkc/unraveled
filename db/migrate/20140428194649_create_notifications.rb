class CreateNotifications < ActiveRecord::Migration
  def change
    create_table :notifications do |t|
      t.integer :user_id
      t.references :notifiable, polymorphic: true
      t.integer :event_id
      t.boolean :is_read

      t.timestamps
    end
    add_index :notifications, :user_id
  end
end
