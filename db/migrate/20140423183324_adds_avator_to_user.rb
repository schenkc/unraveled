class AddsAvatorToUser < ActiveRecord::Migration
  def change
    add_attachment :users, :avatar
  end
end
