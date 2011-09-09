require 'spec_helper'
require 'yaml'
include ActiveModel::Lint::Tests

describe Settings do

  before :all do
    FileUtils.cp Rails.root.join("vendor", "assets", "images", "stock", "stock01.jpg").to_s, Rails.root.join("public", "stock01.jpg").to_s
    Settings.load_custom_file
  end

  custom_settings = {
    :title        => "Custom Title",
    :use_logo     => false,
    :logo         => Rails.root.join("public", "stock01.jpg"),
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

  CUSTOM_SETTINGS = Rails.root.join("config", "settings_#{Rails.env}.yml")
  before :each do
    File.open(CUSTOM_SETTINGS, 'w+') { |f| f.write(custom_settings.to_yaml) }
    Settings.load_custom_file
    @settings = Settings.new
  end
  
  it 'should have the correct class methods' do
    Settings.should respond_to :site
    Settings.should respond_to :defaults
    Settings.should respond_to :custom
  end

  it 'should have the correct instance methods' do
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

    @settings.use_logo = "1"
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

    @settings.currency = "gbp"
    @settings.save
    Settings.load_custom_file
    Settings.currency.should == :gbp
    Settings.currency.should be_an_instance_of Symbol
  end
  
  it 'should handle hashes' do
    Settings.defaults[:image_sizes].should be_an_instance_of HashWithIndifferentAccess
    Settings.image_sizes.should == custom_settings[:image_sizes]
    Settings.image_sizes.should be_an_instance_of HashWithIndifferentAccess

    @settings.image_sizes = {"image_sizes" => {"size" => "1"}}
    @settings.save
    Settings.load_custom_file
    Settings.image_sizes.should == {:image_sizes => {:size => 1}}.with_indifferent_access
    Settings.image_sizes.should be_an_instance_of HashWithIndifferentAccess
  end

  it 'should handle uploaded files' do
    Settings.defaults[:logo].should be_an_instance_of Pathname
    Settings.logo.should == custom_settings[:logo]
    Settings.logo.should be_an_instance_of Pathname

    @settings.logo = ActionDispatch::Http::UploadedFile.new({ :tempfile => File.new(custom_settings[:logo].to_s), :filename => "stock01.jpg", :type => "image/jpg" })
    @settings.save
    Settings.load_custom_file
    Settings.logo.should == Rails.root.join("public", "uploads", "stock01.jpg")
    Settings.logo.should be_an_instance_of Pathname
  end

  after :all do
    FileUtils.rm_rf CUSTOM_SETTINGS
    FileUtils.rm Rails.root.join("public", "uploads", "stock01.jpg")
    Settings.load_custom_file
  end
  
end
