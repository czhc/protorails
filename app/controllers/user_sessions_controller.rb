class UserSessionsController < ApplicationController
  def new
    session[:user_action] = :signin
    redirect_to root_path    
  end

  def create
    user = User.find_by_login_or_email(user_session_params[:username])
    if user && user.authenticate(user_session_params[:password])
      sanitize_user_form
      session[:user_id] = user.id
      flash[:notice] = "Logged in"
      redirect_to root_url, notice: "Logged in"
    else
      session[:user_username] = user_session_params[:username]
      session[:user_action] = :signin
      flash[:error] = "Invalid username or password"
      redirect_to root_url
    end
  end

  def destroy
    sign_out current_user if current_user
    flash[:notce] = "Logged Out"
    redirect_to root_path
  end

  private
    def user_session_params
      params.require(:user_session).permit(:username, :password, :remember_me)
    end
end
