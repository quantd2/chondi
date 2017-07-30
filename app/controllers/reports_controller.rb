class ReportsController < ApplicationController
  before_action :authenticate_user!, :find_reportable

  def create
    @report = @reportable.reports.new(user_id: current_user.id)
    respond_to do |format|
      if @report.save
        format.html { redirect_back fallback_location: :back, notice: "Cám ơn bạn đã báo cáo thành công." }
        format.js
      else
        format.html { redirect_back fallback_location: :back, alert: "Vui lòng thử lại sau."}
        format.js
      end
    end
  end

  # def destroy
  #   @report.destroy
  #   redirect_to :back, notice: "Xoá báo cáo thành công."
  # end

  private

  def find_reportable
    @reportable = Comment.find_by_id(params[:comment_id]) if params[:comment_id]
    @reportable = Poll.find_by_id(params[:poll_id]) if params[:poll_id]
  end

end
