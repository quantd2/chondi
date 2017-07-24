class OptionsController < ApplicationController
  before_action :authenticate_user!

  def index
    @options = Option.all
  end

  def show
    @option = Option.find(params[:id])
  end

  def vote
    value = params[:type] == "up" ? 1 : 0
    @option = Option.find(params[:id])
    @option.add_or_update_evaluation(:votes, value, current_user)
    @option.touch
    respond_to do |format|
      format.html { redirect_to :back, info: "Cám ơn bạn đã bầu chọn!" }
      format.js
    end
  end
end
