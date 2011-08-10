class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :check_for_user
  before_filter { Settings.reload! } # TODO: remove when settings are refactored
  helper_method :current_user
  
  def current_user
    @current_user ||= User.try(:find, session[:user_id]) rescue nil
  end
  private :current_user

  def check_for_user
    redirect_to login_path, :alert => "Must be logged in acess that page." if !current_user
  end
  private :check_for_user

end
