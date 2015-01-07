class SubscribersController < ApplicationController
  def create
    @subscriber = Subscriber.new(subscriber_params)
    if @subscriber.save
    else
    end
  end

  def destroy
    @subscriber = Subscriber.find_by_email(params[:id])
    if @subscriber.destroy
    else
    end
  end

  protected
  def subscriber_params
    params.require(:subscriber).permit(:email)
  end
end
