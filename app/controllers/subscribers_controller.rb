class SubscribersController < ApplicationController
  include ActionView::Helpers::UrlHelper
  layout false

  def create
    @subscriber = Subscriber.new(subscriber_params)
    if @subscriber.save
      respond_to do |format|
        format.js do 
          flash.now[:notice] = "Success! Check your email inbox soon."
          render 'create'
        end
      end
    else
      respond_to do |format|
        format.js do
          if @subscriber.errors.get(:email).try(:include?, "has already been taken")
            flash.now[:error] = "You have already subscribed. Please check your inbox for an activation email."
          else
            flash.now[:error] = "Invalid email address."
          end
          render 'error'
        end
      end
    end
  end

  def activate
    @subscriber = Subscriber.find_by_activation_code(params[:activation_code])
    if @subscriber
      unless @subscriber.activate!
        flash.now[:error] = "Whoops, something went wrong."
      end
    else
      flash.now[:error] = "Invalid subscriber."
    end
  end

  def unsubscribe
    email = verifier.verify(params[:auth_token])
    @subscriber = Subscriber.find_by_email(email)
    if @subscriber
      unless @subscriber.unsubscribe!
        flash.now[:error] = "Whoops, something went wrong."
      end
    else
      flash.now[:error] = "Invalid subscriber."
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
