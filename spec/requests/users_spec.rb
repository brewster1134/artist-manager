require 'spec_helper'

describe "Users" do
  let(:user) {Factory(:user)}
  
  describe "sessions" do

    it "logs in existing users with email/username and logs out" do
      visit login_path

      # no credentials filled in
      click_button "Login"
      page.should have_content("Invalid")

      # only login filled in
      fill_in "Login", :with => user.email
      click_button "Login"
      page.should have_content("Invalid")

      # valid credentials (with email)
      fill_in "Login", :with => user.email
      fill_in "Password", :with => user.password
      click_button "Login"
      current_path.should == home_path
      page.should have_content("Logged in")

      #logs out
      visit logout_path
      current_path.should == home_path
      page.should have_content("Logged out")
      visit login_path

      # valid credentials (with username)
      fill_in "Login", :with => user.username
      fill_in "Password", :with => user.password
      click_button "Login"
      current_path.should == home_path
      page.should have_content("Logged in")
    end
    
  end
  
  describe "passwords" do
    it "sends an email to a valid user and sets their token when password reset request is made" do
      visit change_password_request_path

      # invalid email
      fill_in "Email", with: "nobody@domain.com"
      click_button "Send Request"
      current_path.should == change_password_request_path
      page.should have_content("not found")
      ActionMailer::Base.deliveries.should be_empty

      # valid email
      fill_in "Email", with: user.email
      click_button "Send Request"
      current_path.should == login_path
      page.should have_content("email was sent")
      ActionMailer::Base.deliveries.last.to.should include(user.email)
    end

    it "updates the user password when confirmation matches" do
      user = Factory(:user, :password_reset_token => "something")
      visit change_password_path(token: user.password_reset_token)

      fill_in "Password", :with => "newpassword"
      click_button "Change Password"
      page.should have_content("doesn't match confirmation")

      fill_in "Password", :with => "newpassword"
      fill_in "Password confirmation", :with => "newpassword"
      click_button "Change Password"
      current_path.should == home_path
      page.should have_content("Password is changed")
      User.find(user.id).password_reset_token.should be_nil
    end
  end
end
