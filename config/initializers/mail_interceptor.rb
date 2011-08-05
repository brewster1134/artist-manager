class MailInterceptor
  def self.delivering_email(message)
    message.subject = "#{message.to} #{message.subject}"
    message.to = Settings.email.interceptor
  end 
end
ActionMailer::Base.register_interceptor(MailInterceptor) if Rails.env.development? 
