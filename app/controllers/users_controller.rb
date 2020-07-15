class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:following, :followers]
  def show
    @user = User.find(params[:id])
    @my_posts = @user.microposts.paginate(page: params[:my_page], per_page: 3)
    @favorite_posts = @user.favorite_posts.paginate(page: params[:favorite_page], per_page: 3)
  end

  def index
    @users = User.paginate(page: params[:page])
  end

  def following
    @title = "Following"
    @user  = User.find(params[:id])
    @users = @user.following.paginate(page: params[:page])
    render 'show_follow'
  end

  def followers
    @title = "Followers"
    @user  = User.find(params[:id])
    @users = @user.followers.paginate(page: params[:page])
    render 'show_follow'
  end
end
