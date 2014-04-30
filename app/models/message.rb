class Message < ActiveRecord::Base

  validates :sender_id, :receiver_id, :body, presence: true
  validates :is_seen, :sender_delete, :receiver_delete, inclusion: { in: [true, false] }
  
  before_validation :set_defaults, on: [:create]
  after_commit :set_notification, on: [:create]

  # scope :seen, -> { where(is_seen: true) }
  # scope :unseen, -> { where(is_seen: false) }
  # scope :undeleteable, -> { where(sender_delete: false).where(receiver_delete: false) }

  belongs_to(
    :sender,
    class_name: "User",
    foreign_key: :sender_id,
    primary_key: :id
  )

  belongs_to(
    :receiver,
    class_name: "User",
    foreign_key: :receiver_id,
    primary_key: :id
  )
  
  has_many(
    :notifications,
    as: :notifiable,
    inverse_of: :notifiable,
    dependent: :destroy
  )

  private

  def set_defaults
    self.sender_delete = false
    self.receiver_delete = false
    self.is_seen = false
    return true
  end
  
  def set_notification
    notification = self.notifications.unread.event(:new_message).new
    notification.user = self.receiver
    notification.save
  end

end