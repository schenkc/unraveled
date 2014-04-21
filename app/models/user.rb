class ActiveRecord::Base
  def self.generate_unique_token_for(field)
    begin
      token = SecureRandom.base64(16)
    end until !self.exists?(field => token)
    token
  end
end

class User < ActiveRecord::Base

  attr_reader :password
  validates :email, presence: true, uniqueness: true
  validates :password_digest, presence: true
  validates :session_token, presence: true
  validates :password, length: { minimum: 6, allow_nil: true }
  before_validation :ensure_session_token

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
  end

  def password=(password)
    self.password_digest = BCrypt::Password.create(password)
  end

  def is_password?(password)
    BCrypt::Password.new(self.password_digest).is_password?(password)
  end

  private

  def ensure_session_token
    self.session_token = self.class.generate_session_token
  end

end