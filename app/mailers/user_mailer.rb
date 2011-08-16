class UserMailer < ActionMailer::Base
  default from: Settings.email_no_reply

  def password_reset(user)
    @token = user.password_reset_token
    mail to: user.email
  end
end
