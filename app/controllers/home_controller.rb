class HomeController < ApplicationController
  skip_before_filter :check_for_user
  include Google

  def splash
    if Settings.splash_page
      images = Settings.splash_page_featured ? Work.where(:featured => true).collect{|w| w.images} : WorkImage.all
      @view = (params[:view] || Settings.splash_page_view).to_sym
      @images = case @view
      when :slideshow
        images.shuffle.first(15)
      when :random
        images.sample
      end
      render :layout => "splash"
    else
      redirect_to home_path
    end
  end

  def show
    @tags = Work.tags
  end
  
  def events
    @events = calendar_events.select{ |e| e.start_time.to_date > Date.today}.sort_by(&:start_time)
  rescue => e
    @events = e
  end

end
