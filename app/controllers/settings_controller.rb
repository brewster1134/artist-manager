class SettingsController < ApplicationController
  
  def edit
    @settings = Settings.new
  end
  def update
    @settings = Settings.new(params[:settings])
    if @settings.save
      notice = "Settings Saved."
      if @settings.resize_images
        system "rake recreate_images &"
        notice << "  Images are being resized. This may take awhile."
      end
      redirect_to edit_settings_path, :notice => notice 
    else
      flash.alert = "There was a problem saving the settings."
      render :edit
    end
  end
end
