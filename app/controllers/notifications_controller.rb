class NotificationsController < ApplicationController

  def show
    notification = current_user.notifications.find(params[:id])
    notification.update(is_read: true)
    redirect_to notification.url
  end

  def index
    @notifications = current_user.notifications
    render :index
  end

end