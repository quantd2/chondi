class WelcomeController < ApplicationController
  # before_action :authenticate_user!

  def index
    # @polls = Poll.all.includes(:options).desc.page params[:page]
    @polls = Poll.text_search(params[:query]).includes(:options).page(params[:page])
  end

  def about
  end

end
