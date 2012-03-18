class PagesController < ApplicationController
  def home
    if signed_in?
      @user = current_user
      redirect_to user_path(current_user) + "/dashboard"
    end
    @title = "Home"
  end

  def about
    @title = "About"
  end

end
