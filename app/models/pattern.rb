class Pattern < ActiveRecord::Base

  include PgSearch
  multisearchable :against => [:name, :category, :yarn_name,
      :yarn_weight, :stitch_col, :stitch_row, :swatch,
      :swatch_stitch, :needles, :amount_yarn, :sizes,
      :price, :notes, :url]

  has_attached_file :instruction
  validates_attachment :instruction, content_type: { content_type: "application/pdf" }

  after_commit :set_notification, on: [:create]

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
    primary_key: :id,
    dependent: :destroy
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
    inverse_of: :pattern,
    dependent: :destroy
  )

  has_many(
    :tags,
    through: :pattern_tags,
    source: :tag
  )

  has_many :pictures, as: :imageable, dependent: :destroy

  has_many(
    :notifications,
    as: :notifiable,
    inverse_of: :notifiable,
    dependent: :destroy
  )

  private

  def set_notification
    self.designer.followers.each do |follower|
      notification = self.notifications.unread.event(:new_pattern_from_leader).new
      notification.user = follower
      notification.save
    end
  end

end