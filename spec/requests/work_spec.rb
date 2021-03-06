require 'spec_helper'

describe "Work" do

  before :each do
    @work  = Factory(:work)
    login
  end

  it "shows an index" do
    get work_index_path
    response.status.should be(200)
  end
  
  it "creates a new work" do
    visit new_work_path
    current_path.should == new_work_path
    title = "Working Title"
    click_button "Create Work"
    page.should have_content("blank")
    fill_in "Title", :with => title
    click_button "Create Work"
    current_path.should == edit_work_path(title.parameterize)
    page.should have_content("created")
  end

  it "updates a work" do
    visit edit_work_path(@work)
    current_path.should == edit_work_path(@work)
    fill_in "Title", :with => ""
    click_button "Update Work"
    page.should have_content("blank")
    fill_in "Title", :with => @work.title
    click_button "Update Work"
    current_path.should == work_path(@work)
    page.should have_content("updated")
  end

  # it "destroys a work" do
    # delete work_path(@work)
    # current_path.should == work_index_path
    # page.should have_content("deleted")
  # end

end
