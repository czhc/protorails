class SubscribersController < ApplicationController
  layout false

  def create
    @subscriber = Subscriber.new(subscriber_params)
    if @subscriber.save
      render 'create'
    else
      render 'new'
    end
  end

  def activate
    @subscriber = Subscriber.find_by_activation_code(params[:activation_code])
    if @subscriber
      unless @subscriber.activate!
        flash[:error] = "Whoops, something went wrong."
      end
    else
      flash[:error] = "Invalid subscriber."
    end
  end

  def unsubscribe
    email = verifier.verify(params[:auth_token])
    @subscriber = Subscriber.find_by_email(email)
    if @subscriber
      unless @subscriber.unsubscribe!
        flash[:error] = "Whoops, something went wrong."
      end
    else
      flash[:error] = "Invalid subscriber."
    end
  rescue ActiveSupport::MessageVerifier::InvalidSignature
    Rails.logger.info "ERROR: InvalidSignature for #{params[:auth_token]}"
    redirect_to root_path
  end

  protected
  def subscriber_params
    params.require(:subscriber).permit(:email)
  end
end
