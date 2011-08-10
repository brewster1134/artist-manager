class WorkImagesController < ApplicationController
  respond_to :html, :only => [:index]
  respond_to :json

  def index
    @work = Work.find_by_url(params[:work_id])
    @images = @work.images
    respond_with(@images) do |format|
      format.json { render :json => @images.collect { |i| i.to_jq_upload }.to_json }
      format.html { @images }
    end
  end
  
  def create
    @work = Work.find_by_url(params[:work_id])
    @image = @work.images.new(image: params[:image])
    if @image.save
      render :json => [ @image.to_jq_upload ].to_json
    else 
      render :json => [ @image.to_jq_upload.merge({ :error => "custom_failure" }) ].to_json
    end
  end
  
  def destroy
    @image = WorkImage.find(params[:id])
    @image.destroy
    render :json => true
  end
  
end
