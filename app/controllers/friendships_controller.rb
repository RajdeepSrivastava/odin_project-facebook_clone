class FriendshipsController < ApplicationController
    before_action :authenticate_user!
  
    def create
      receiver = User.find(params[:receiver_id])
      current_user.send_friend_request(receiver)
  
      Notification.create(user: receiver, content: "#{current_user.email} sent you a friend request.")
      
      redirect_to receiver, notice: 'Friend request sent!'
    end
  
    def accept
      friendship = Friendship.find(params[:id])
      friendship.update(status: 'accepted')
  
      sender = friendship.sender
      Notification.create(user: sender, content: "#{current_user.email} accepted your friend request.")
      
      redirect_to users_path, notice: 'Friend request accepted!'
    end
  end
  