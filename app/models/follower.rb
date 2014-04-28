class Follower < ActiveRecord::Base

  validates :leader_id, :follower_id, presence: true
  validates_uniqueness_of :follower_id, scope: :leader_id

  after_commit :set_notification, on: [:create]

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

  has_many(
    :notifications,
    as: :notifiable,
    inverse_of: :notifiable,
    dependent: :destroy
  )

  private

  def set_notification
    notification = self.notifications.unread.event(:new_follower).new
    notification.user = self.leader
    notification.save
  end
end