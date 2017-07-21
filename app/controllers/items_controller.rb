class ItemsController < ApplicationController
  def index
    @items = Item.all
  end

  def show
    @item = Item.find(params[:id])
  end

  def vote
    value = params[:type] == "up" ? 1 : -1
    @item = Item.find(params[:id])
    @item.add_evaluation(:votes, value, current_user)
    redirect_to :back, notice: "Cám ơn bạn đã bầu chọn!"
  end
end
