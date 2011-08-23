require 'yaml'

class Settings < ActiveRecord::Base
  attr_accessor :logo

  CUSTOM_FILE = Rails.root.join("config", "settings_#{Rails.env}.yml")
  after_initialize :populate_instance_accessors

  cattr_accessor :site, :defaults
  @@site = {
    :splash_page_views =>   ["slideshow", "random"],
    :home_show_tag_views => ["accordion", "plain"],
    :series_show_views =>   ["slideshow", "scroller", "plain"],
    :work_show_views =>     ["slideshow", "scroller", "plain"]
  }
  @@defaults = {
    :title =>                 "Artist Manager",
    :use_logo =>              true,
    :splash_page =>           true,
    :splash_page_view =>      :slideshow,
    :splash_page_featured =>  false,
    :currency =>              :usd,
    :google_email =>          "email@gmail.com",
    :google_password =>       "password",
    :google_calendar =>       "My Calendar",
    :email_interceptor =>     "developer@domain.com",
    :email_no_reply =>        "noreply@domain.com",
    :home_show_tag_view =>    :accordion,
    :series_show_view =>      :slideshow,
    :work_show_view =>        :slideshow,
    :image_sizes =>           {
      :home => {
        :show => {
          :series => [160, 75],
          :work => [75, 75],
        },
        :splash => {
          :slideshow => [966, 402],
          :random => [966, 402]
        }
      },
      :series => {
        :show => {
          :work => [145, 145],
          :slideshow => [962, 400],
          :image_scroller_height => 75 
          
        }
      },
      :work => {
        :edit => [80, 80],
        :index => {
          :series => [300, 145],
          :work => [145, 145]
        },
        :show => {
          :slideshow => [962, 400],
          :image_scroller_height => 75,
          :plain => [150,150]
        }
      }
    }
  }.with_indifferent_access
  # If changes are made to :image_sizes, the following needs to be run to resize all existing imags to the new sizes.
  # WorkImage.all.each{|w| w.image.recreate_versions!}
  
  @@custom = File.exists?(CUSTOM_FILE) ? YAML::load(File.open(CUSTOM_FILE, 'r')) : {}
  @@custom.delete_if{ |k,v| !@@defaults.keys.include?(k) || v == "" }
  @@defaults.merge(@@custom).each do |k,v|
    cattr_accessor k
    attr_accessor k
    self.send("#{k}=", v)
  end

  validates :title,                 :presence => true
  validates :use_logo,              :inclusion => { :in => ["0", "1"] }
  validates :splash_page,           :inclusion => { :in => ["0", "1"] }
  validates :splash_page_view,      :inclusion => { :in => @@site[:splash_page_views] }
  validates :splash_page_featured,  :inclusion => { :in => ["0", "1"] }
  validates :currency,              :inclusion => { :in => Money::Currency::TABLE.stringify_keys.keys }
  validates :google_email,          :email => true,
                                    :allow_blank => true
  validates :email_interceptor,     :email => true
  validates :email_no_reply,        :email => true
  validates :home_show_tag_view,    :inclusion => { :in => @@site[:home_show_tag_views] }
  validates :series_show_view,      :inclusion => { :in => @@site[:series_show_views] }
  validates :work_show_view,        :inclusion => { :in => @@site[:work_show_views] }
  
  def save
    if self.valid?
      # Save Logo
      if self.logo && self.logo.content_type =~ /image/
        File.open(self.logo.open, 'rb') do |l|
          File.open(Dir.glob(File.join(Rails.root, 'public', 'uploads', 'logo.*')).first, 'w+b') {|out| out.write(l.read) }
        end
      end

      # Save settings
      hash = {}
      @@defaults.each do |k,v|
        value = self.send(k)
        value = case v
        when TrueClass, FalseClass
          value.to_i > 0
        when Symbol
          value.to_sym
        when Hash
          value.with_indifferent_access
        else
          value
        end
        hash[k.to_s] = value if !value.nil? && value != "" && value != v
      end
      puts hash.inspect
      File.open(CUSTOM_FILE, 'w+') { |f| f.write hash.to_yaml }
    end
  end

  def populate_instance_accessors
    @@defaults.merge(@@custom).each do |k,v|
      self.send("#{k}=", v) if self.send(k).nil?
    end
  end
  private :populate_instance_accessors
  
end