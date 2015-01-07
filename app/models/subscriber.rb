class Subscriber < ActiveRecord::Base
  belongs_to :user
  enum state: { pending: 0, activated: 1, unsubscribed: 2}
  before_create :make_activation_code

  protected
  def make_activation_code
    self.activation_code = Tripsales::Utility.make_token
  end
end
