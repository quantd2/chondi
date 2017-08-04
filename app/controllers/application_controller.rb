class ApplicationController < ActionController::Base
  # protect_from_forgery with: :exception
  protect_from_forgery with: :null_session, only: Proc.new { |c| c.request.format.json? }

  def admin?
    if !current_user.admin
      flash[:alert] = "Unauthorized access"
      redirect_to root_path
    end
  end

  def facebook_logout
    puts session[:fb_token]
    redirect_to "https://www.facebook.com/logout.php&access_token=#{session[:fb_token]}"
  end
end
