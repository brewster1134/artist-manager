class HomeController < ApplicationController
  skip_before_filter :check_for_user
  include Google

  def splash
    redirect_to home_path unless Settings.splash_page
  end

  def show
    @events = calendar_events.select{ |e| e.start_time.to_date > Date.today}.sort_by(&:start_time)
  end

end
