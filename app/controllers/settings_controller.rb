class SettingsController < ApplicationController
  
  def edit
    @settings = Settings.new
  end
  def update
    @settings = Settings.new(params[:settings])
    if @settings.save
      redirect_to edit_settings_path, :notice => "Settings Saved."
    else
      flash.alert = t('update.failure', :x => "There was a problem saving the settings.")
      render :edit
    end
  end
end
