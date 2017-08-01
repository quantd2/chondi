class CommentsController < ApplicationController
  before_action :find_commentable, :authenticate_user!
  before_action :correct_user, only: :destroy

  def create
    @comment = @commentable.comments.new comment_params.merge(user_id: current_user.id, poll_id: @poll_id)
    respond_to do |format|
      if @comment.save
        format.html { redirect_back fallback_location: :back, info: "Cám ơn bạn đã tham gia bình luận!" }
        format.js
      else
        format.html { redirect_back fallback_location: :back, notice: "Vui lòng thử lại sau!"}
        format.js
      end
    end
  end

  def destroy
    @comment.destroy
    respond_to do |format|
      format.html { redirect_back fallback_location: :back, notice: "Xoá lời bình thành công." }
      format.js
    end
  end

  def vote
    value = params[:type] == "up" ? 1 : 0
    @comment = Comment.find(params[:id])
    @comment.add_or_update_evaluation(:votes, value, current_user)
    # @commnet.touch
    respond_to do |format|
      format.html { redirect_to :back, info: "Cám ơn bạn đã bầu chọn!" }
      format.js
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:body)
  end

  def find_commentable
    if params[:comment_id]
      @commentable = Comment.find_by_id(params[:comment_id])
      @poll_id = @commentable.poll_id
    elsif params[:poll_id]
      @commentable = Poll.find_by_id(params[:poll_id])
      @poll_id = @commentable.id
    end
  end

  def correct_user
    @comment = current_user.comments.find_by_id(params[:id])
    redirect_to root_path if @comment.nil?
  end
end
