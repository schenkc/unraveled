class Pattern < ActiveRecord::Base

  has_attached_file :instruction
  validates_attachment :instruction, content_type: { content_type: "application/pdf" }


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

  has_many(
    :pattern_tags,
    class_name: "PatternTag",
    foreign_key: :pattern_id,
    primary_key: :id,
    inverse_of: :pattern
  )

  has_many(
    :tags,
    through: :pattern_tags,
    source: :tag
  )

end