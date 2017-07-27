class WelcomeController < ApplicationController
  # before_action :authenticate_user!
  # caches_page :index, layout: false
  # expire_page controller: "options", action: "vote"


  def index
    @polls = Poll.all.includes(:options).desc.page params[:page]
    # @polls = Poll.all.desc.page params[:page]
  end
end
