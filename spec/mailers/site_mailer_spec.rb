require "spec_helper"
ActionMailer::Base.default_url_options[:host] = "localhost:3000"

describe SiteMailer do
  describe "price_request" do
    let(:work) { Factory(:work) }
    let(:email) { Email.new(:from => "user@email.com", :skip => [:to, :subject, :message]) }
    let(:mail) { SiteMailer.price_request(work, email) }

    it "renders the headers" do
      mail.subject.should match "Price Request for"
      mail.to.should eq([Settings.email_general])
      mail.from.should eq(["user@email.com"])
    end
  end
end
