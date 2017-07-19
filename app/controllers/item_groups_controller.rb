class ItemGroupsController < ApplicationController
  def index
   @item_groups = ItemGroup.all
  end

  def show
    @item_group = ItemGroup.find(params[:id])
  end

  def new
    @item_group = ItemGroup.new
    # @item_group.items.new
  end

  def create
    @item_group = ItemGroup.new(item_group_params)
    if @item_group.save and @item_group.items.size.between? 2, 5
      redirect_to url_for(:controller => :welcome, :action => :index), notice: "Tạo thành công nhóm chọn."
    else
      redirect_to new_item_group_path, alert: "Bạn chỉ được có 2-5 lựa chọn"
    end
  end

  def edit
    @item_group = ItemGroup.find(item_group_params)
  end

  def update
    @item_group = ItemGroup.find(params[:id])
    if @item_group.update_attributes(item_group_params)
      redirect_to @item_group, notice: "Successfully updated survey."
    else
      render :edit
    end
  end

  def destroy
    @item_group = ItemGroup.find(item_group_params)
    @item_group.destroy
    redirect_to surveys_url, notice: "Successfully destroyed survey."
  end

  def item_group_params
    params.require(:item_group).permit(:name, items_attributes: [:name, :_destroy])
  end
end
