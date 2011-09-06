class SessionsController < ApplicationController
  skip_before_filter :check_for_user, :except => [:destroy]
  include Rails.application.routes.url_helpers

  def new
    redirect_to home_path, :alert => "You are already logged in." if current_user 
  end

  def create
    user = User.find_by_login(params[:session][:login]).try(:authenticate, params[:session][:password])
    if user
      session[:user_id] = user.id
      redirect_to home_path, :notice => "Logged in!"
    else
      flash.alert = "Invalid email or password"
      render :new
    end
  end
  
  def destroy
    session[:user_id] = nil
    redirect_to home_path, :notice => "Logged out!"
  end

end
