class Pattern < ActiveRecord::Base

  belongs_to(
    :designer,
    class_name: "User",
    foreign_key: :designer_id,
    primary_key: :id
  )

  has_many(
    :pattern_users,
    class_name: "UserLikedPattern",
    foreign_key: :pattern_id,
    primary_key: :id
  )

  has_many(
    :fans,
    through: :pattern_users,
    source: :owner
  )

end