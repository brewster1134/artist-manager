class WorkController < ApplicationController
  helper TagHelper, VideoLinkHelper
  skip_before_filter :check_for_user, :only => [:index, :show]
  autocomplete :tag, :name, :class_name => 'ActsAsTaggableOn::Tag'
  
  def index
    tag = params[:tag] unless params[:tag].blank? || params[:tag] == 'all' 
    @series = tag ? Series.all & Series.tagged_with(tag) : Series.all
    @work = tag ? Work.not_in_series(tag) : Work.not_in_series 
  end
  
  def show
    flash.now.alert = "Payment Cancelled" if params[:payment_cancelled]
    @work = Work.find_by_url(params[:id])
    @view = (params[:view] || (:video_link if @work.video_link.present?) || (@work.view if @work.view.present?) || Settings.work_show_view).to_sym
  end
  
  def new
    @work = Work.new
  end
  
  def create
    @work = Work.new(params[:work])
    if @work.save
      redirect_to edit_work_path(@work), :notice => [t('create.success', :x => @work.title), t('work.create')] * "  "
    else
      flash.alert = t('create.failure', :x => "Work")
      render :new
    end
  end
  
  def edit
    @work = Work.find_by_url(params[:id])
  end
  
  def update
    @work = Work.find_by_url(params[:id])
    if @work.update_attributes(params[:work])
      redirect_to @work, :notice => t('update.success', :x => @work.title)
    else
      @work.title = @work.title_was if @work.title_changed?
      flash.alert = t('update.failure', :x => "Work")
      render :edit
    end
  end
  
  def destroy
    @work = Work.find_by_url(params[:id])
    if @work.destroy
      redirect_to work_index_path, :notice => t('destroy.success', :x => @work.title)
    else
      flash.alert = t('destroy.failure', :x => @work.title)
      render :edit
    end
  end

  def price_request
    @work = Work.find_by_url(params[:work_id])
    @email = Email.new(params[:email])
    logger.info @email.inspect
    @email.skip = [:to, :subject, :message]
  end
  
end
