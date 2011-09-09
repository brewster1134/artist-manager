class ApplicationController < ActionController::Base
  include Mobile
  protect_from_forgery
  before_filter :setup_app
  before_filter :check_for_user
  
  def current_user
    @current_user ||= User.try(:find, session[:user_id]) rescue nil
  end
  private :current_user
  helper_method :current_user

  def setup_app
    ActionMailer::Base.default_url_options[:host] = request.host_with_port
    request.format = :mobile if mobile?
  end
  private :setup_app

  def check_for_user
    redirect_to login_path, :alert => "Must be logged in to access that page." if !current_user
  end
  private :check_for_user

end
