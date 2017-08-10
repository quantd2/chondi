class ApplicationController < ActionController::Base
  # protect_from_forgery with: :exception
  protect_from_forgery with: :null_session, only: Proc.new { |c| c.request.format.json? }
  before_filter :configure_permitted_parameters, if: :devise_controller?
  def admin?
    if !current_user.admin
      flash[:alert] = "Unauthorized access"
      redirect_to root_path
    end
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:name, :email, :password,
      :password_confirmation, :remember_me, :image) }
    devise_parameter_sanitizer.permit(:account_update) { |u| u.permit(:name, :email, :password,
      :password_confirmation, :current_password, :image) }
  end
end
