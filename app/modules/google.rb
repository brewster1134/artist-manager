module Google
  include GCal4Ruby
  
  def calendar_events
    if service
      calendar = Calendar.find(service, title: Settings.google_calendar).first
      if calendar.present?
        if calendar.exists?
          return calendar.events
        else
          flash.now.alert = "No events were found on the calendar." if current_user
        end 
      else
        flash.now.alert = "No calendar with the name '#{Settings.google_calendar}' could be found." if current_user
      end 
    end
    return []
  end
  
  def service
    service = Service.new
    begin
      service.authenticate(Settings.google_email, Settings.google_password)
      return service
    rescue GData4Ruby::HTTPRequestFailed
      flash.now.alert = "There was a problem authenticating your google account" if current_user
      return nil
    end
  end
  private :service
  
end