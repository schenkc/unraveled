class AddsFileUplaodToPattern < ActiveRecord::Migration
  def change
    add_attachment :patterns, :instruction
  end
end
