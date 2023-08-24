class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:index]

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @pending_friend_requests = @user.user_pending_requests
  end


  def edit_profile
    @user = current_user
  end

  def update_profile
    @user = current_user
    if @user.update(user_params)
      flash[:notice] = "Profile updated successfully."
      redirect_to user_profile_path(@user)
    else  
      flash.now[:alert] = "Profile update failed."
      render :edit_profile
    end
  end

  def profile
    @user = User.find(params[:id])
  end

  private 

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation, :first_name, :last_name, :dob, :profile_photo)
  end
  
end