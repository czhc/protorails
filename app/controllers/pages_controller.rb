class PagesController < ApplicationController
  def home
    @user = current_user || User.new(email: session[:user_action] == "signup" ? session[:user_email] : nil)
    render
    sanitize_user_form  
  end
end
