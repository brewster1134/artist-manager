require 'yaml'

class Settings
  include ActiveModel::Validations
  include ActiveModel::Conversion

  CUSTOM_SETTINGS = Rails.root.join("config", "settings_#{Rails.env}.yml")
  attr_accessor :resize_images
  cattr_accessor :site, :defaults, :custom
  @@site = {
    :payment_modules =>     [:paypal],
    :splash_page_views =>   [:slideshow, :random],
    :home_show_tag_views => [:accordion, :plain],
    :series_show_views =>   [:slideshow, :scroller, :plain],
    :work_show_views =>     [:slideshow, :scroller, :plain]
  }
  @@defaults = {
    :title =>                 "Artist Manager",
    :use_logo =>              true,
    :logo =>                  Rails.root.join("public", "logo.png"),
    :use_background_image =>  true,
    :background_image =>      Rails.root.join("public", "background_image.png"),
    :background_color =>      "grey",
    :currency =>              :usd,
    :email_general =>         "email@domain.com",
    :email_no_reply =>        "noreply@domain.com",
    :email_interceptor =>     "developer@domain.com",
    :google_email =>          "email@gmail.com",
    :google_password =>       "password",
    :google_calendar =>       "My Calendar",
    :payment_module =>        :paypal,
    :paypal_api_username =>   "email_api.gmail.com",
    :paypal_api_password =>   "password",
    :paypal_api_signature =>  "A1B2C3D4E5F6G7H8I9",
    :splash_page =>           true,
    :splash_page_view =>      :slideshow,
    :splash_page_featured =>  false,
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
  
  validates :title,                 :presence => true
  validates :use_logo,              :inclusion => { :in => [true, false] }
  validates :use_background_image,  :inclusion => { :in => [true, false] }
  validates :splash_page,           :inclusion => { :in => [true, false] }
  validates :splash_page_view,      :inclusion => { :in => @@site[:splash_page_views] }
  validates :splash_page_featured,  :inclusion => { :in => [true, false] }
  validates :currency,              :inclusion => { :in => Money::Currency::TABLE.keys }
  validates :google_email,          :email => true,
                                    :allow_blank => true
  validates :payment_module,        :inclusion => { :in => @@site[:payment_modules] }
  validates :email_general,         :email => true
  validates :email_interceptor,     :email => true
  validates :email_no_reply,        :email => true
  validates :home_show_tag_view,    :inclusion => { :in => @@site[:home_show_tag_views] }
  validates :series_show_view,      :inclusion => { :in => @@site[:series_show_views] }
  validates :work_show_view,        :inclusion => { :in => @@site[:work_show_views] }
  
  def self.load_custom_file
    @@custom = File.exists?(CUSTOM_SETTINGS) ? YAML::load(File.open(CUSTOM_SETTINGS, 'r')).with_indifferent_access : {}
    @@custom.delete_if{ |k,v| !@@defaults.keys.include?(k) || v == "" }
    @@merged = @@defaults.merge(@@custom).each do |k,v|
      cattr_accessor k
      attr_accessor k
      self.send("#{k}=", v)
    end
  end
  load_custom_file

  def save

    # Prepare settings
    hash = {}
    @@defaults.each do |k,v|
      value = self.send(k)
      if value
        value = case v
        when TrueClass, FalseClass
          value.respond_to?(:to_i) ? value.to_i > 0 : value
        when Symbol
          value.downcase.to_sym
        when Pathname
          if value.is_a?(ActionDispatch::Http::UploadedFile) && value.content_type =~ /image/
            new_file = Rails.root.join('public', 'uploads', value.original_filename)
            FileUtils.mv value.tempfile.path, new_file.to_s, :force => true
            new_file
          elsif Settings.custom[k.to_sym]
            Settings.custom[k.to_sym]
          end
        when Hash
          if k == "image_sizes"
            value = convert_image_sizes_hash_to_integers(value)
            self.resize_images = true if value != @@merged[:image_sizes] && value === @@defaults[:image_sizes]
          end
          value.with_indifferent_access
        else
          value
        end
        self.send("#{k}=", value)
        hash[k.to_s] = value if !value.nil? && value != "" && value != v
      end
    end

    if self.valid? 
      # Save changed settings to file
      File.open(CUSTOM_SETTINGS, 'w+') { |f| f.write hash.with_indifferent_access.to_yaml }
      return true
    else
      return false
    end
  end

  def initialize(attributes = @@merged)
    attributes.each do |k,v|
      self.send("#{k}=", v)
    end
  end
  
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

  def persisted?; false; end
end