class Follower < ActiveRecord::Base
  
  validates :leader_id, :follower_id, presence: true
  validates_uniqueness_of :follower_id, scope: :leader_id
  
  belongs_to(
    :leader,
    class_name: "User",
    foreign_key: :leader_id,
    primary_key: :id
  )
  
  belongs_to(
    :follower,
    class_name: "User",
    foreign_key: :follower_id,
    primary_key: :id
  )
  
end