class SessionsController < ApplicationController
  skip_before_filter :check_for_user, :except => [:destroy]
  include Rails.application.routes.url_helpers

  def new
    if current_user
      redirect_to root_path, :alert => "Already logged in.  <a href='#{logout_path}'>Logout</a> first to login with a different account.".html_safe
    end
  end

  def create
    user = User.find_by_login(params[:session][:login]).try(:authenticate, params[:session][:password])
    if user
      session[:user_id] = user.id
      redirect_to root_path, :notice => "Logged in!"
    else
      flash.alert = "Invalid email or password"
      render :new
    end
  end
  
  def destroy
    session[:user_id] = nil
    redirect_to root_url, :notice => "Logged out!"
  end

end
