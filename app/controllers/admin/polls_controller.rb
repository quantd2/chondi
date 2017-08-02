class Admin::PollsController < ApplicationController
  before_action :authenticate_user!, :admin?

  def index
    @polls = Poll.all.includes(:reports).page params[:page]
  end

  def show
    @poll = Poll.includes(:options, :comments).find_by_id(params[:id])
    @comments = @poll.comments.page params[:page]
  end

  def new
    @poll = Poll.new
  end

  def create
    @poll = current_user.polls.build(poll_params)
    if @poll.save and @poll.options.size.between? 2, 5
      redirect_to url_for(:controller => :welcome, :action => :index), notice: "Tạo thành công nhóm chọn."
    else
      redirect_to new_poll_path, alert: "Bạn chỉ được có 2-10 lựa chọn"
    end
  end

  def destroy
    @poll = Poll.find_by_id(params[:id])
    @poll.destroy
    redirect_back fallback_location: :back, notice: "Xoá nhóm chọn thành công."
  end

  private

  def poll_params
    params.require(:poll).permit(:name, :user_id, options_attributes: [:name, :image, :remote_image_url, :_destroy])
  end
end
