class WelcomeController < ApplicationController
  # before_action :authenticate_user!

  def index
    @item_groups = ItemGroup.all
  end
end
