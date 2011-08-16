class WorkController < ApplicationController
  skip_before_filter :check_for_user, :only => [:index, :show]
  autocomplete :tag, :name, :class_name => 'ActsAsTaggableOn::Tag'
  
  def index
  end
  
  def show
    @work = Work.find_by_url(params[:id])
  end
  
  def new
    @work = Work.new
  end
  
  def create
    @work = Work.new(params[:work])
    if @work.save
      redirect_to edit_work_path(@work), :notice => "#{@work.title} was created!  Now add some images!"
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
      redirect_to work_path(@work), :notice => "#{@work.title} was successfully updated."
    else
      flash.alert = t('update.failure', :x => "Work")
      render :edit
    end
  end
  
end
