require 'spec_helper'

describe Work do
  let(:work) { Factory(:work) }
  
  it 'should have the correct attributes' do
    work.should respond_to :title
    work.should respond_to :series_id
    work.should respond_to :tag_list
    work.should respond_to :description
    work.should respond_to :media
    work.should respond_to :dimensions
    work.should respond_to :completion_year
    work.should respond_to :video_link
    work.should respond_to :for_sale
    work.should respond_to :price
    work.should respond_to :price_currency
    work.should respond_to :quantity
    work.should respond_to :view
    work.should respond_to :featured
    work.should respond_to :shipping
    work.should respond_to :shipping_currency
  end
  
  it 'should be found by paramaterized title' do
    work.title = "This is A Series with Numb3rs & Symbols and UPPERCASE"
    work.url.should == work.title.parameterize
    work.save 
    Work.find_by_url(work.url).should == work
  end
  
end
