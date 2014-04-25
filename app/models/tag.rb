class Tag < ActiveRecord::Base

  include PgSearch
  multisearchable :against => :name

  has_many(
    :pattern_tags,
    class_name: "PatternTag",
    foreign_key: :tag_id,
    primary_key: :id
  )

  has_many(
    :patterns,
    through: :pattern_tags,
    source: :pattern
  )

end