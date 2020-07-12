class FavoritesController < ApplicationController
  before_action :authenticate_user!

  def create
    micropost = Micropost.find(params[:micropost_id])
    current_user.add_favorite(micropost)
    redirect_back(fallback_location: root_path)
  end

  def destroy
    micropost = Favorite.find(params[:id]).micropost
    current_user.remove_favorite(micropost)
    redirect_back(fallback_location: root_path)
  end
end
