require 'spec_helper'
require 'yaml'
include ActiveModel::Lint::Tests

describe Settings do
  custom_settings = {
    :title        => "Custom Title",
    :use_logo     => false,
    :currency     => :eur,
    :image_sizes  => {
      :home => {
        :show => {
          :series => {
            :height => 75
          }
        }
      }
    }
  }.with_indifferent_access

  CUSTOM_FILE = Rails.root.join("config", "settings_#{Rails.env}.yml")
  before :each do
    File.open(CUSTOM_FILE, 'w+') { |f| f.write(custom_settings.to_yaml) }
    Settings.load_custom_file
    @settings = Settings.new
  end
  
  it 'should have the correct class methods' do
    Settings.should respond_to :site
    Settings.should respond_to :defaults
    Settings.should respond_to :custom
  end

  it 'should have the correct instance methods' do
    @settings.should respond_to :logo
    @settings.should respond_to :resize_images
  end
  
  it 'should handle strings' do
    Settings.defaults[:title].should == "Artist Manager"
    Settings.defaults[:title].should be_an_instance_of String
    Settings.title.should == custom_settings[:title]
    Settings.title.should be_an_instance_of String

    @settings.title = "New Title"
    @settings.save
    Settings.load_custom_file
    Settings.title.should == "New Title"
    Settings.title.should be_an_instance_of String
  end
  
  it 'should handle boolean values' do
    Settings.defaults[:use_logo].should == true
    Settings.defaults[:use_logo].should be_an_instance_of TrueClass
    Settings.use_logo.should == custom_settings[:use_logo]
    Settings.use_logo.should be_an_instance_of FalseClass

    @settings.use_logo = true
    @settings.save
    Settings.load_custom_file
    Settings.use_logo.should == true
    Settings.use_logo.should be_an_instance_of TrueClass
  end
  
  it 'should handle symbols' do
    Settings.defaults[:currency].should == :usd
    Settings.defaults[:currency].should be_an_instance_of Symbol
    Settings.currency == custom_settings[:currency]
    Settings.currency.should be_an_instance_of Symbol

    @settings.currency = :gbp
    @settings.save
    Settings.load_custom_file
    Settings.currency.should == :gbp
    Settings.currency.should be_an_instance_of Symbol
  end
  
  it 'should handle hashes' do
    Settings.defaults[:image_sizes].should be_an_instance_of HashWithIndifferentAccess
    Settings.image_sizes.should == custom_settings[:image_sizes]
    Settings.image_sizes.should be_an_instance_of HashWithIndifferentAccess

    @settings.image_sizes = {:image_sizes => {:size => "1"}}
    @settings.save
    Settings.load_custom_file
    Settings.image_sizes.should == {:image_sizes => {:size => 1}}.with_indifferent_access
    Settings.image_sizes.should be_an_instance_of HashWithIndifferentAccess
  end

  after :all do
    FileUtils.rm_rf CUSTOM_FILE
    Settings.load_custom_file
  end
  
end
