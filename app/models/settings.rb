require 'yaml'

class Settings < ActiveRecord::Base
  CUSTOM_FILE = Rails.root.join("config", "settings_#{Rails.env}.yml")
  after_initialize :populate_instance_accessors
  attr_accessor :logo, :resize_images
  cattr_accessor :site, :defaults, 
  @@site = {
    :payment_modules =>     ["Paypal"],
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
    :payment_module =>        "Paypal",
    :paypal_api_username =>   "email_api.gmail.com",
    :paypal_api_password =>   "password",
    :paypal_api_signature =>  "A1B2C3D4E5F6G7H8I9",
    :email_interceptor =>     "developer@domain.com",
    :email_no_reply =>        "noreply@domain.com",
    :email_general =>         "email@domain.com",
    :home_show_tag_view =>    :accordion,
    :series_show_view =>      :slideshow,
    :work_show_view =>        :slideshow,
    :image_sizes =>           {
      :home => {
        :show => {
          :series => {
            :width => 160,
            :height => 75
          },
          :work => {
            :width => 75,
            :height => 75
          }
        },
        :splash => {
          :slideshow => {
            :width => 966,
            :height => 402
          },
          :random => {
            :width => 966,
            :height => 402
          }
        }
      },
      :series => {
        :show => {
          :work => {
            :width => 145,
            :height => 145
          },
          :slideshow => {
            :width => 962,
            :height => 400
          },
          :scroller => {
            :height => 75
          }
        }
      },
      :work => {
        :edit => {
          :work => {
            :width => 80,
            :height => 80
          }
        },
        :index => {
          :series => {
            :width => 300,
            :height => 145
          },
          :work => {
            :width => 145,
            :height => 145
          }
        },
        :show => {
          :slideshow => {
            :width => 962,
            :height => 400
          },
          :scroller => {
            :height => 75
          },
          :plain => {
            :width => 160,
            :height => 160
          }
        }
      }
    }
  }.with_indifferent_access
  
  @@custom = File.exists?(CUSTOM_FILE) ? YAML::load(File.open(CUSTOM_FILE, 'r')) : {}
  @@custom.delete_if{ |k,v| !@@defaults.keys.include?(k) || v == "" }
  @@merged = @@defaults.merge(@@custom).each do |k,v|
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
  validates :payment_module,        :inclusion => { :in => @@site[:payment_modules] }
  validates :email_general,         :email => true
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

      # Prepare settings
      hash = {}
      @@defaults.each do |k,v|
        value = self.send(k)
        value = case v
        when TrueClass, FalseClass
          value.to_i > 0
        when Symbol
          value.to_sym
        when Hash
          if k == "image_sizes"
            value = convert_image_sizes_hash_to_integers(value)
            self.resize_images = true if value != @@merged[:image_sizes]
            value
          end
        else
          value
        end
        hash[k.to_s] = value if !value.nil? && value != "" && value != v
      end

      # Save changed settings to file
      File.open(CUSTOM_FILE, 'w+') { |f| f.write hash.to_yaml }
    end
  end
  
  def populate_instance_accessors
    @@defaults.merge(@@custom).each do |k,v|
      self.send("#{k}=", v) if self.send(k).nil?
    end
  end
  private :populate_instance_accessors
  
  def convert_image_sizes_hash_to_integers(hash)
    hash.inject({}) do |h, (k,v)|
      if v.is_a? Hash
        h[k] = convert_image_sizes_hash_to_integers(v)
      else
        h[k] = v.to_i
      end
      h
    end
  end
  private :convert_image_sizes_hash_to_integers

end