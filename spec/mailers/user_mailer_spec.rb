require "spec_helper"
ActionMailer::Base.default_url_options[:host] = "localhost:3000"
include General

describe UserMailer do
  describe "password_reset" do
    let(:user) { Factory(:user, :password_reset_token => generate_token) }
    let(:mail) { UserMailer.password_reset(user) }

    it "renders the headers" do
      mail.subject.should eq("Password Reset")
      mail.to.should eq([user.email])
      mail.from.should eq([Settings.email_no_reply])
    end

    it "renders the body" do
      mail.body.encoded.should match user.password_reset_token
    end
  end

end
