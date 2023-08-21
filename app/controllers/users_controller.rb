class UsersController < ApplicationController
  before_action :authenticate_user!, except: :index

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @pending_friend_requests = @user.pending_friend_requests
  end
end
