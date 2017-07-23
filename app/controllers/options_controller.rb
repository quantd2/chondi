class OptionsController < ApplicationController
  before_action :authenticate_user!

  def index
    @options = Option.all
  end

  def show
    @option = Option.find(params[:id])
  end

  def vote
    if current_user && params[:poll_id] && params[:option]
      value = 1 if params[:type] == "up"
      @poll = Poll.find_by_id(params[:poll_id])
      @option = Option.find(params[:id])
      if @option && @poll && !current_user.voted_for?(@poll)
        @option.add_or_update_evaluation(:votes, value, current_user)
        respond_to do |format|
          format.html { redirect_to :back, info: "Cám ơn bạn đã bầu chọn!" }
          # format.js
        end
      else
       render js: 'alert(\'Your vote cannot be saved. Have you already voted?\');'
      end
    else
      render js: 'alert(\'Your vote cannot be saved.\');'
    end
  end
end
