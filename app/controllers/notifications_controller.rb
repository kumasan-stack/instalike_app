class NotificationsController < ApplicationController
  before_action :authenticate_user!
  before_action :correct_user, only: :destroy
  
  def index
    @notifications = Notification.where("passive_user_id = ?", current_user.id)
  end

  def destroy
    @notification.destroy
    redirect_back(fallback_location: root_path)
  end

  private
    def correct_user
      @notification = current_user.notifications.find_by(id: params[:id])
      redirect_to root_url if @notification.nil?
    end
end
