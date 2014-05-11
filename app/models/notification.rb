class Notification < ActiveRecord::Base
  include Rails.application.routes.url_helpers

  EVENTS = {
    1 => :new_follower,
    2 => :new_pattern_from_leader,
    3 => :pattern_in_new_library,
    4 => :new_message
  }

  EVENT_IDS = EVENTS.invert

  belongs_to(
    :user,
    class_name: "User",
    foreign_key: :user_id,
    primary_key: :id,
    inverse_of: :notifications,
    counter_cache: true
  )

  belongs_to(
    :notifiable,
    inverse_of: :notifications,
    polymorphic: true,
    # counter_cache: true
  )

  validates :event_id, inclusion: { in: EVENTS.keys }
  validates :is_read, inclusion: { in: [true, false] }
  validates :notifiable, :user, presence: true

  scope :read, -> { where(is_read: true) }
  scope :unread, -> { where(is_read: false) }
  scope :event, -> (event_name){ where(event_id: EVENT_IDS[event_name]) }

  def event_name
    EVENTS[self.event_id]
  end

  def url
    case self.event_name
    when :new_follower
      follower = self.notifiable.follower
      user_url(follower)
    when :new_pattern_from_leader
      pattern = self.notifiable
      pattern_url(pattern)
    when :pattern_in_new_library
      library = self.notifiable.owner
      user_url(library)
    when :new_message
      message = self.notifiable
      "/messages##{message.id}"
    end
  end

  def text
    case self.event_name
    when :new_follower
      follower = self.notifiable.follower
      follower_name = (follower.name ? follower.name : follower.email)
      "It looks like #{follower_name} likes your work"
    when :new_pattern_from_leader
      pattern = self.notifiable
      leader = pattern.designer
      designer_name = leader.show_name
      "#{designer_name} has something new!"
    when :pattern_in_new_library
      library = self.notifiable
      pattern = library.pattern
      owner_name = (library.owner.name ? library.owner.name : library.owner.email)
      "#{owner_name} has added #{pattern.name} to their library."
    when :new_message
      message = self.notifiable
      "#{message.sender.show_name} has sent you a message."
    end
  end

  def default_url_options
    options = {}
    options[:host] = Rails.env.production? ? "unraveled.schenkc.com" : "localhost:3000"
    options
  end

end