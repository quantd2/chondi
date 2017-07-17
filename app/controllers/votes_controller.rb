class VotesController < ApplicationController
  before_action :find_votable

  def new
    @vote = Vote.new
  end

  def create
    @vote = @votable.votes.new vote_params

    if @vote.save
      redirect_to :back, notice: 'Your vote was successfully posted!'
    else
      redirect_to :back, notice: "Your vote wasn't posted!"
    end
  end

  private

  def vote_params
    params.require(:vote).permit(:user_id, :votable_id)
  end

  def find_votable
    @votable = Comment.find_by_id(params[:comment_id]) if params[:comment_id]
    @votable = Item.find_by_id(params[:item_id]) if params[:item_id]
  end
end
