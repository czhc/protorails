class UsersController < ApplicationController
  before_filter :require_user, only: [:edit, :update, :destroy]
  before_action :set_user, only: [:update, :destroy]

  def new
    session[:user_action] = :signup
    redirect_to root_path
  end

  def edit
    @user = current_user
  end

  def create
    @user = User.new(user_params)
    if @user.save
      sign_in @user
      sanitize_user_form
    else
      session[:user_email] = user_params[:email]
      session[:user_action] = :signup
      flash[:error] = @user.errors.full_messages.first
    end
    redirect_to root_path
  end

  def update
    # respond_to do |format|
    #   if @user.update(user_params)
    #     format.html { redirect_to @user, notice: 'User was successfully updated.' }
    #     format.json { render :show, status: :ok, location: @user }
    #   else
    #     format.html { render :edit }
    #     format.json { render json: @user.errors, status: :unprocessable_entity }
    #   end
    # end
  end

  def destroy
    # @user.destroy
    # respond_to do |format|
    #   format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
    #   format.json { head :no_content }
    # end
  end

  private
    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(:login, :email, :password, :password_confirmation)
    end
end
