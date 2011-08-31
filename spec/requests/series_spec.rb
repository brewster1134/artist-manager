require 'spec_helper'

describe "Series" do

  before :each do
    @series  = Factory(:series)
    login
  end

  it "creates a new series" do
    visit new_series_path
    current_path.should == new_series_path
    title = "Working Title"
    click_button "Create Series"
    page.should have_content("blank")
    fill_in "Title", :with => title
    click_button "Create Series"
    current_path.should == edit_series_path(title.parameterize)
    page.should have_content("created")
  end

  it "updates a series" do
    visit edit_series_path(@series)
    current_path.should == edit_series_path(@series)
    fill_in "Title", :with => ""
    click_button "Update Series"
    page.should have_content("blank")
    fill_in "Title", :with => @series.title
    click_button "Update Series"
    current_path.should == edit_series_path(@series)
    page.should have_content("updated")
  end

  # it "destroys a series" do
    # delete series_path(@series)
    # current_path.should == series_index_path
    # page.should have_content("deleted")
  # end

end
