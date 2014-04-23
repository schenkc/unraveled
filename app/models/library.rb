class Library < ActiveRecord::Base

  validates :pattern_id, :user_id, presence: true

end