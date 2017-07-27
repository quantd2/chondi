class PollsController < ApplicationController
  before_action :authenticate_user!, except: :show
  # caches_action :new

  def index
   @polls = Poll.all
  end

  def show
    # @poll = Poll.find(params[:id])
    @poll = Poll.includes(:options).find_by_id(params[:id])
    @comments = @poll.comments.page params[:page]
  end

  def new
    @poll = Poll.new
  end

  def create
    @poll = Poll.new(poll_params)
    if @poll.save and @poll.options.size.between? 2, 5
      redirect_to url_for(:controller => :welcome, :action => :index), notice: "Tạo thành công nhóm chọn."
    else
      redirect_to new_poll_path, alert: "Bạn chỉ được có 2-5 lựa chọn"
    end
  end

  def edit
    @poll = Poll.find(poll_params)
  end

  def update
    @poll = Poll.find(params[:id])
    if @poll.update_attributes(poll_params)
      redirect_to @poll, notice: "Successfully updated poll."
    else
      render :edit
    end
  end

  def destroy
    @poll = Poll.find(poll_params)
    @poll.destroy
    redirect_to polls_url, notice: "Successfully destroyed poll."
  end

  def poll_params
    params.require(:poll).permit(:name, options_attributes: [:name, :image, :remote_image_url, :_destroy])
  end
end
