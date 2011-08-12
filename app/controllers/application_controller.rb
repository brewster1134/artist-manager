class ApplicationController < ActionController::Base
  protect_from_forgery
  helper_method :current_user
  before_filter :check_for_user
  before_filter :setup_app
  
  def current_user
    @current_user ||= User.try(:find, session[:user_id]) rescue nil
  end
  private :current_user

  def check_for_user
    redirect_to login_path, :alert => "Must be logged in to access that page." if !current_user
  end
  private :check_for_user
  
  def setup_app
    ActionMailer::Base.default_url_options[:host] = request.host_with_port
  end
  private :setup_app

end
