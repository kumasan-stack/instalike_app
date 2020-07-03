class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @microposts = @user.microposts.all
  end

  def index
    @users = User.all
  end
end
