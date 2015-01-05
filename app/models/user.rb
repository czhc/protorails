class User < ActiveRecord::Base
  has_secure_password
  validates_uniqueness_of :login, :email
  validates_presence_of :password, :on => :create

  def self.find_by_login_or_email(credential)
    User.find_by_login(credential) || User.find_by_email(credential)
  end
end
