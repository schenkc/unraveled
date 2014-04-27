class PatternTag < ActiveRecord::Base

  validates :tag, :pattern, presence: true

  belongs_to(
    :tag,
    class_name: "Tag",
    foreign_key: :tag_id,
    primary_key: :id,
    inverse_of: :pattern_tags
  )

  belongs_to(
    :pattern,
    class_name: "Pattern",
    foreign_key: :pattern_id,
    primary_key: :id,
    inverse_of: :pattern_tags
  )

end