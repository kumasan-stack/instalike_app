class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :correct_user, only: :destroy

  def create
    comment = current_user.comments.build(comment_params)
    if comment.save
      flash[:success] = "Comment created!"
      Notification.create(notification_params)
      redirect_back(fallback_location: root_path)
    else
      flash.now[:danger] = comment.errors.full_messages
      @feed_items = current_user.feed.paginate(page: params[:page])
      render 'static_pages/home'
    end
  end

  def destroy
    @comment.destroy
    flash[:success] = "Comment deleted"
    redirect_back(fallback_location: root_path)
  end

  private
    def comment_params
      params.require(:comment).permit(:micropost_id, :content)
    end

    def notification_params
      params.require(:comment).permit(:micropost_id, :passive_user_id, :active_user_id, :activity)
    end

    def correct_user
      @comment = current_user.comments.find_by(id: params[:id])
      redirect_to root_url if @comment.nil?
    end
end
