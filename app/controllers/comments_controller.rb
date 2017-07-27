class CommentsController < ApplicationController
  before_action :find_commentable

  def create
    @comment = @commentable.comments.new comment_params.merge(user_id: current_user.id)
    respond_to do |format|
      if @comment.save
        format.html { redirect_to :back, info: "Cám ơn bạn đã bầu chọn!" }
        format.js
      else
        format.html { redirect_to :back, notice: "Your comment wasn't posted!"}
        format.js
      end
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:body, :user_id)
  end

  def find_commentable
    @commentable = Comment.find_by_id(params[:comment_id]) if params[:comment_id]
    @commentable = Poll.find_by_id(params[:poll_id]) if params[:poll_id]
  end
end
