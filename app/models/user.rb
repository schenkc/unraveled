class ActiveRecord::Base
  def self.generate_unique_token_for(field)
    begin
      token = SecureRandom.base64(16)
    end until !self.exists?(field => token)
    token
  end
end

class User < ActiveRecord::Base

  include PgSearch
  multisearchable :against => [:email, :name]

  attr_reader :password
  attr_reader :password_confirmation
  validates :email, :session_token, :activation_token, presence: true, uniqueness: true
  validates :password_digest, presence: true
  validates :password, length: { minimum: 6, allow_nil: true }, confirmation: true
  before_validation :ensure_session_token, on: [:create]
  before_validation :ensure_activation_token, on: [:create]
  # before_validation :password_confirmation, presence: true, on: [:create]
  # validates_confirmation_of :password

  has_attached_file :avatar, styles: { thumb: "100x100>" }, :default_url => "/images/:style/missing.png"
  validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\z/

  has_many(
    :designs,
    class_name: "Pattern",
    foreign_key: :designer_id,
    primary_key: :id,
    dependent: :destroy
  )

  has_many(
    :user_patterns,
    class_name: "UserLikedPattern",
    foreign_key: :owner_id,
    primary_key: :id,
    dependent: :destroy
  )

  has_many(
    :liked_patterns,
    through: :user_patterns,
    source: :pattern,
    dependent: :destroy
  )
  
  has_many(
    :follower_entries,
    class_name: "Follower",
    foreign_key: :follower_id,
    primary_key: :id
  )
  
  has_many(
    :leaders,
    through: :follower_entries,
    source: :leader,
    dependent: :destroy
  )
  
  has_many(
  :leader_entries,
  class_name: "Follower",
  foreign_key: :leader_id,
  primary_key: :id
  )
  
  has_many(
    :followers,
    through: :leader_entries,
    source: :follower,
    dependent: :destroy
  )
  

  def self.find_by_credentials(email, secret)
    user = User.find_by(email: email)
    if user
      user.is_password?(secret) ? user : nil
    else
      nil
    end
  end

  def self.generate_session_token
    self.generate_unique_token_for(:session_token)
  end

  def reset_session_token!
    self.session_token = User.generate_session_token
    self.save!
    self.session_token
  end

  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end

  def is_password?(password)
    BCrypt::Password.new(self.password_digest).is_password?(password)
  end

  private

  def ensure_session_token
    self.session_token ||= self.class.generate_session_token
  end

  def ensure_activation_token
    self.activation_token ||= self.class.generate_unique_token_for(:activation_token)
  end

end