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
      redirect_to edit_series_path(@series), :notice => [t('create.success', :x => @series.title), t('series.create')] * "  " 
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
      redirect_to edit_series_path(@series), :notice => t('update.success', :x => @series.title)
    else
      @series.title = @series.title_was if @series.title_changed?
      flash.alert = t('update.failure', :x => @series.title)
      render :edit
    end
  end
  
  def destroy
    @series = Series.find_by_url(params[:id])
    if @series.destroy
      redirect_to work_index_path, :notice => t('destroy.success', :x => @series.title)
    else
      flash.alert = t('destroy.failure', :x => @series.title)
      render :edit
    end
  end

end
