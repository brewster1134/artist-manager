require 'spec_helper'

describe Email do
  let(:email) { Email.new }
  
  it 'should have the correct attributes' do
    email.should respond_to :to
    email.should respond_to :from
    email.should respond_to :subject
    email.should respond_to :message
    email.should respond_to :skip
  end
  
  context "when skip is used" do 
    it "should skip validation" do
      email.should_not be_valid
      email.skip = [:to, :from, :subject, :message]
      email.should be_valid
    end
    
  end

end
