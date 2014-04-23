class UserLikedPattern < ActiveRecord::Base

  validates :pattern_id, :owner_id, presence: true

  belongs_to(
    :owner,
    class_name: "User",
    foreign_key: :owner_id,
    primary_key: :id
  )

  belongs_to(
    :pattern,
    class_name: "Pattern",
    foreign_key: :pattern_id,
    primary_key: :id
  )

end