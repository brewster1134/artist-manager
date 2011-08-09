class WorkController < ApplicationController
  skip_before_filter :check_for_user, :only => [:index, :show]
  autocomplete :tag, :name, :class_name => 'ActsAsTaggableOn::Tag'
  
  def index
    @work = Work.all
  end
  
  def show
    @work = Work.find_by_url(params[:id])
  end
  
  def new
    @work = Work.new
  end
  
  def create
    @work = Work.new(params[:work])
  end
  
  def edit
    @work = Work.find_by_url(params[:id])
  end
  
  def update
    @work = Work.find_by_url(params[:id])
    if @work.update_attributes(params[:work])
      redirect_to work_path(@work), :notice => "#{@work.title} was successfully updated."
    else
      render :edit
    end
  end
  
end
