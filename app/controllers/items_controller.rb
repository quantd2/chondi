class ItemsController < ApplicationController
  before_action :authenticate_user!

  def index
    @items = Item.all
  end

  def show
    @item = Item.find(params[:id])
  end

  def vote
    value = params[:type] == "up" ? 1 : -1
    @item = Item.find(params[:id])
    @item.add_or_update_evaluation(:votes, value, current_user)
    respond_to do |format|
      format.html { redirect_to :back, notice: "Cám ơn bạn đã bầu chọn!" }
      format.js
    end
  end
end
