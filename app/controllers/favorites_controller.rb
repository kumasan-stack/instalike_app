class FavoritesController < ApplicationController
  before_action :authenticate_user!

  def create
    micropost = Micropost.find(params[:favorite][:micropost_id])
    current_user.add_favorite(micropost)
    Notification.create(notification_params)
    redirect_back(fallback_location: root_path)
  end

  def destroy
    micropost = Favorite.find(params[:id]).micropost
    current_user.remove_favorite(micropost)
    redirect_back(fallback_location: root_path)
  end

  private
    def notification_params
      params.require(:favorite).permit(:micropost_id, :passive_user_id, :active_user_id, :activity)
    end
end