class Subscriber < ActiveRecord::Base
  belongs_to :user
  validates :email, uniqueness: {
                      case_sensitive: false,
                    }, 
                    presence: true,
                    format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i,
                              message: "Invalid email format."}

  enum state: { pending: 0, activated: 1, unsubscribed: 2}
  before_create :make_activation_code

  def activate!
    self.activated_at = Time.now
    self.activation_code = nil
    self.state = :activated
    self.save
  end

  def unsubscribe!
    self.unsubscribed_at = Time.now
    self.state = :unsubscribed
    self.save
  end

  protected
  def make_activation_code
    self.activation_code = Tripsales::Utility.make_token
  end
end
