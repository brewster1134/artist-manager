class HomeController < ApplicationController
  skip_before_filter :check_for_user

  def show
  end

end
