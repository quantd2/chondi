class WelcomeController < ApplicationController
  # before_action :authenticate_user!

  def index
    @polls = Poll.all.includes(:options).desc.page params[:page]
  end

  def about
    
  end

  def feedback

  end
end
