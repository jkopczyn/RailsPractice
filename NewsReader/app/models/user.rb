class User < ActiveRecord::Base
  validates :username, :session_token, presence: true
  validates :password_digest, presence: {message: "Password can't be blank", null: false}
  validates :password, length: {minimum: 6, null: true}
  before_validation :ensure_session_token

  attr_reader :password

  def generate_session_token
    SecureRandom.urlsafe_base64
  end

  def reset_session_token!
    self.session_token = self.generate_session_token
    self.save!
  end

  def password=(password)
    @password = password
    @password_digest = BCrypt::Password.create(password)
  end

  def is_password?(password)
    BCrypt::Password.new(self.password_digest).is_password?(password)
  end

  def self.find_by_credentials(username, password)
    user = User.find_by_username(username)

    user && user.is_password?(password) ? user : nil
  end

  private
  def ensure_session_token
    @session_token ||= self.generate_session_token
  end

end
