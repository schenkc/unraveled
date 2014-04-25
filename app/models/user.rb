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

  attr_reader :password
  validates :email, :session_token, :activation_token, presence: true, uniqueness: true
  validates :password_digest, presence: true
  validates :password, length: { minimum: 6, allow_nil: true }
  before_validation :ensure_session_token, only: [:create]
  before_validation :ensure_activation_token, only: [:create]

  has_attached_file :avatar, styles: { thumb: "100x100>" }, :default_url => "/images/:style/missing.png"
  validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\z/

  has_many(
    :designs,
    class_name: "Pattern",
    foreign_key: :designer_id,
    primary_key: :id
  )

  has_many(
    :user_patterns,
    class_name: "UserLikedPattern",
    foreign_key: :owner_id,
    primary_key: :id
  )

  has_many(
    :liked_patterns,
    through: :user_patterns,
    source: :pattern
  )

  has_many :tags, as: :taggable

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