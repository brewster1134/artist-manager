class SeriesController < ApplicationController
  skip_before_filter :check_for_user, :only => :show

  def show
    @series = Series.find_by_url(params[:id])
    @view = (params[:view] || (@series.view if @series.view.present?) || Settings.series_show_view).to_sym
  end

  def new
    @series = Series.new
  end
  
  def create
    @series = Series.new(params[:series])
    if @series.save
      redirect_to edit_series_path(@series), :notice => "#{@series.title} was created!  You can now add work to it."
    else
      flash.alert = t('create.failure', :x => "Series")
      render :new
    end

  end
  
  def edit
    @series = Series.find_by_url(params[:id])
  end
  
  def update
    @series = Series.find_by_url(params[:id])
    if @series.update_attributes(params[:series])
      redirect_to edit_series_path(@series), :notice => "#{@series.title} was successfully updated."
    else
      @series.title = @series.title_was if @series.title_changed?
      flash.alert = t('update.failure', :x => "Series")
      render :edit
    end
  end
  
  def destroy
    
  end

end
