class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def admin?
    if !current_user.admin
      flash[:alert] = "Unauthorized access"
      redirect_to root_path
    end
  end
end
