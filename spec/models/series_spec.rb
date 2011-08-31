require 'spec_helper'

describe Series do
  let(:series) { Factory(:series) }
  
  it 'should have the correct attributes' do
    series.should respond_to :works
    series.should respond_to :title
    series.should respond_to :description
    series.should respond_to :view
  end
  
  it 'should be found by paramaterized title' do
    series.title = "This is A Title with Numb3rs & Symbols and UPPERCASE"
    series.url.should == series.title.parameterize
    series.save 
    Series.find_by_url(series.url).should == series
  end
end
