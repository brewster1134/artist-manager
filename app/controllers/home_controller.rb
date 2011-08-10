class HomeController < ApplicationController
  skip_before_filter :check_for_user

  def splash
    redirect_to :action => :show unless Settings.splash_page
  end

  def show
  end

end
