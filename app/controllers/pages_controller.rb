class PagesController < ApplicationController
  def home
    @user = current_user || User.new(email: session[:user_action] == "signup" ? session[:user_email] : nil)
  end
end
