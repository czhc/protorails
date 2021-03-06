class User < ActiveRecord::Base
  has_secure_password

  has_one :subscriber

  RESERVED_NAMES = %w{ logout login register signup activate verify forgot reset resend_activation verifying about
                      terms unsubscribe account users session questions admin }

  validates :login, uniqueness: {
                      case_sensitive: false,
                    }, 
                    presence: true, 
                    length: { minimum: 3, maximum: 15}, 
                    format: { with: /\A[a-z0-9_-]+\z/i,
                              message: "only letters, numbers, - and _ are allowed"}, 
                    exclusion: { in: RESERVED_NAMES,
                                  message: "Login not available."}

  validates :email, uniqueness: {
                      case_sensitive: false,
                    }, 
                    presence: true,
                    format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i,
                              message: "Invalid email format."}

  validates :password,  confirmation: true,
                        length: { minimum: 8, maximum: 22 }, 
                        format: { with: /\A[a-z0-9_-]+\z/i }

  after_create :create_subscriber

  def self.find_by_login_or_email(credential)
    User.find_by_login(credential) || User.find_by_email(credential)
  end

  protected

  def create_subscriber
    return if self.subscriber
    self.subscriber = Subscriber.create(email: email)
  end
end
