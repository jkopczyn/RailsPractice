require 'bcrypt'
require 'byebug'

class User < ActiveRecord::Base

  validates :user_name, :session_token, presence: true, uniqueness: true
  after_initialize :ensure_set_token

  has_many :cats

  def self.generate_session_token
    SecureRandom.urlsafe_base64
  end

  def self.find_by_credentials(user_name, password)
    maybe_user = User.find_by(user_name: user_name)
    if maybe_user.password_digest.is_password?(password)
      return maybe_user
    else
      raise "No user with that name and password"
    end
  end

  def reset_session_token!
    self.session_token = User.generate_session_token
    save!
    session_token
  end

  def password=(plaintext_password)
    self.password_digest = BCrypt::Password.create(plaintext_password)
  end

  def is_password?(plaintext_password)
    password_digest.is_password?(plaintext_password)
  end

  def password_digest
    BCrypt::Password.new(super)
  end

  private
  def ensure_set_token
    #debugger
    self.session_token ||= User.generate_session_token
  end
end
