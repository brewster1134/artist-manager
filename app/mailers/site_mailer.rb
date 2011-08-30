class SiteMailer < ActionMailer::Base
  default to: Settings.email_general
  
  def price_request(work, email)
    @message = email.message
    mail  from: email.from,
          subject: "Price Request for #{work.name}"
  end
end
