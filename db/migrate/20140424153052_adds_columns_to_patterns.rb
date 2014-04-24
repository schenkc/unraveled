class AddsColumnsToPatterns < ActiveRecord::Migration
  def change
    add_column :patterns, :url, :string
  end
end
