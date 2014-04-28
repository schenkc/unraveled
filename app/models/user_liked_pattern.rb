class UserLikedPattern < ActiveRecord::Base

  validates :pattern_id, :owner_id, presence: true

  after_commit :set_notification, on: [:create]

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

  has_many(
    :notifications,
    as: :notifiable,
    inverse_of: :notifiable,
    dependent: :destroy
  )

  private

  def set_notification
    notification = self.notifications.unread.event(:pattern_in_new_library).new
    notification.user = self.pattern.designer
    notification.save
  end

end