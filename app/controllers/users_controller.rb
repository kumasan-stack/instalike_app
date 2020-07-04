class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:index, :show, :following, :followers]
  def show
    @user = User.find(params[:id])
    @microposts = @user.microposts.all
  end

  def index
    @users = User.all
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
