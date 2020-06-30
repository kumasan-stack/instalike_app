class SessionsController < ApplicationController
  # def new
  # end

  # def create
  #   user = User.find_by(email: params[:session][:email].downcase)
  #   if user && user.authenticate(params[:session][:password])
  #     log_in user
  #     params[:session][:remember_me] == "1" ? remember(user) : forget(user)
  #     flash[:success] = "Login succeeded"
  #     redirect_to user
  #   else
  #     flash.now[:danger] = "Invalid email/password combination"
  #     render "static_pages/home"
  #   end
  # end

  # def destroy
  #   log_out if logged_in?
  #   flash[:info] = "Logged out"
  #   redirect_to root_path
  # end
end
