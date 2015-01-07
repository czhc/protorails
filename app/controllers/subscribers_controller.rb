class SubscribersController < ApplicationController
  def create
    @subscriber = Subscriber.new(subscriber_params)
    if @subscriber.save
    else
    end
  end

  def activate
    @subscriber = Subscriber.find_by_activation_code(params[:activation_code])
    if @subscriber
      unless @subscriber.activate!
        flash[:error] = "Whoops, something went wrong."
        redirect_to root_path        
      end
    else
      flash[:error] = "Invalid subscriber."
      redirect_to root_path
    end
  end

  def unsubscribe
    email = verifier.verify(params[:auth_token])
    @subscriber = Subscriber.find_by_email(email)
    if @subscriber
      unless @subscriber.unsubscribe!
        flash[:error] = "Whoops, something went wrong."
        redirect_to root_path
      end
    else
      flash[:error] = "Invalid subscriber."
      redirect_to root_path
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
