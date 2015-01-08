class SubscriberMailer < ApplicationMailer
  include ApplicationHelper
  
  def activation(subscriber)
    @subscriber = subscriber
    @user = @subscriber.user
    @activate_url = activate_url(activation_code: @subscriber.activation_code)
    @unsubscribe_url = unsubscribe_url(auth_token: verifier.generate(@subscriber.email))
    mail(to: @subscriber.email, subject: "*Knock* *knock*")
  end

  def resend_activation(subscriber)
    @subscriber = subscriber
    @user = @subscriber.user
    @activate_url = activate_url(activation_code: @subscriber.activation_code)
    @unsubscribe_url = unsubscribe_url(auth_token: verifier.generate(@subscriber.email))
    mail(to: @subscriber.email, subject: "Hey Miss Carter")
  end
end
