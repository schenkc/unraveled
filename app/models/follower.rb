class Follower < ActiveRecord::Base
  
  belongs_to(
    :leader,
    class_name: "User",
    foreign_key: :follower_id,
    primary_key: :id
  )
  
  belongs_to(
    :follower,
    class_name: "User",
    foreign_key: :leader_id,
    primary_key: :id
  )
end