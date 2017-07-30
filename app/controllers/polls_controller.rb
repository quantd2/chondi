class PollsController < ApplicationController
  before_action :authenticate_user!, except: :show
  before_action :correct_user, only: :destroy

  def index
    @polls = current_user.polls.page params[:page]
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
      redirect_to new_poll_path, alert: "Bạn chỉ được có 2-5 lựa chọn"
    end
  end

  def destroy
    @poll.destroy
    redirect_to polls_url, notice: "Xoá nhóm chọn thành công."
  end

  def report
    value = params[:report] == "up" ? 1
    @poll = Poll.find(poll[:id])
    Report.create(user_id: current_user.id)
    # @option.touch
    respond_to do |format|
      format.html { redirect_to :back, info: "Cám ơn bạn đã bầu chọn!" }
      format.js
    end
  end

  private

  def correct_user
    @poll = current_user.polls.find_by_id(params[:id])
    redirect_to root_path if @poll.nil?
  end

  def poll_params
    params.require(:poll).permit(:name, :user_id, options_attributes: [:name, :image, :remote_image_url, :_destroy])
  end
end
