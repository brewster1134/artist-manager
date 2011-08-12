class UsersController < ApplicationController
  
  def edit
    @user = current_user
  end
  
  def update
    @user = current_user
    if @user.update_attributes(params[:user])
      redirect_to home_path, notice: t('update.success', x: "Your account")
    else
      flash.alert = t('update.failure', x: "Your account")
      render :edit
    end
  end
  
end
