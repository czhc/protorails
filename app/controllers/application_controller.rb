class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :current_user, :require_user, :require_admin,
                :store_location, :redirect_back_or_default, 
                :get_redirect_back_or_default, :sanitize_user_form, :sign_in,
                :sign_out

  def sanitize_user_form
    session[:user_username] = nil
    session[:user_email] = nil
    session[:user_action] = nil
  end

  def sign_in(user)
    session[:user_id] = user.id
  end

  def sign_out(user)
    session[:user_id] = nil
  end

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def require_user
    unless current_user
      store_location
      redirect_to root_path, notice: "You must be logged in to access this page"
      return false
    end
  end

  def require_admin
    unless current_user && current_user.admin?
      store_location
      redirect_to root_path, notice: "You must be an admin to access this page"
      return false
    end
  end

  def store_location
    session[:return_to] = request.original_url rescue nil 
  end

  def redirect_back_or_default(default, opts=nil)
    opts = opts || {}
    redirect_to((session[:return_to] || default), notice: opts[:notice])
    session[:return_to] = nil
  end

  def get_redirect_back_or_default(default)
    redirect = session[:return_to] == root_path ? default : session[:return_to]
    session[:return_to] = nil
    redirect
  end

end
