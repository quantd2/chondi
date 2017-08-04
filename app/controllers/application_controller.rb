class ApplicationController < ActionController::Base
  # protect_from_forgery with: :exception
  protect_from_forgery with: :null_session, only: Proc.new { |c| c.request.format.json? }

  def admin?
    if !current_user.admin
      flash[:alert] = "Unauthorized access"
      redirect_to root_path
    end
  end
end
