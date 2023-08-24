class NotificationsController < ApplicationController
    before_action :authenticate_user!
  
    def index
      @notifications = current_user.notifications.unread
    end
  
    def mark_as_read
      current_user.notifications.unread.update_all(read_status: true)
  
      redirect_to notifications_path
    end
  end
  