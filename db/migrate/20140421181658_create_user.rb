class CreateUser < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :password_digest, null: false
      t.string :email, null: false
      t.string :session_token, null: false
      t.boolean :activate
      t.string :activation_token

      t.timestamps
    end

    add_index :users, :email, unique: true
    add_index :users, :session_token, unique: true
  end
end
