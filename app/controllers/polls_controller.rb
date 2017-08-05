class PollsController < ApplicationController
  before_action :authenticate_user!, except: [:show, :index]
  before_action :correct_user, only: :destroy
  before_action :find_owner, only: :index

  def index
    # @polls = current_user.polls.page params[:page]
    @polls = @user.polls.page params[:page]
  end

  def show
    @poll = Poll.includes(:options, :comments).find_by_id(params[:id])
    @comments = @poll.comments
  end

  def new
    @poll = Poll.new
  end

  def create
    @poll = current_user.polls.build(poll_params)
    if @poll.options.size.between? 2, 5
      if @poll.save
        redirect_to url_for(:controller => :welcome, :action => :index), notice: "Tạo thành công nhóm chọn."
      else
        puts @poll.errors
        redirect_to new_poll_path, alert: "Vui lòng thử lại sau."
      end
    else
      redirect_to new_poll_path, alert: "Bạn chỉ được có 2-5 lựa chọn"
    end
  end

  def destroy
    @poll.destroy
    redirect_to polls_url, notice: "Xoá nhóm chọn thành công."
  end

  private

  def find_owner
    @user = User.find(user_params)
  end

  def correct_user
    @poll = current_user.polls.find_by_id(params[:id])
    redirect_to root_path if @poll.nil?
  end

  def poll_params
    params.require(:poll).permit(:name, options_attributes: [:name, :image, :remote_image_url, :_destroy])
  end

  def user_params
    params.require(:user_id)
  end
end
