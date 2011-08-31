require 'spec_helper'

describe User do
  let(:user) { Factory(:user)}
  
  it 'should have the correct attributes' do
    user.should respond_to :username
    user.should respond_to :email
    user.should respond_to :password
    user.should respond_to :password_confirmation
  end
  
  it 'should be found by searching for username or email' do
    User.find_by_login(user.username).should == user
    User.find_by_login(user.email).should == user
  end
  
end
