require 'yaml'

class Settings < ActiveRecord::Base
  CUSTOM_FILE = Rails.root.join("config", "settings_#{Rails.env}.yml")
  after_initialize :populate_instance_accessors

  cattr_accessor :defaults
  @@defaults = {
    :title =>             "Artist Manager",
    :splash_page =>       true,
    :currency =>          :usd,
    :google_email =>      "email@gmail.com",
    :google_password =>   "password",
    :google_calendar =>   "My Calendar",
    :email_interceptor => "developer@domain.com",
    :email_no_reply =>    "noreply@domain.com"
  }.with_indifferent_access
  
  @@custom = YAML::load(File.open(CUSTOM_FILE, 'r')) || {}
  @@custom.delete_if{ |k,v| !@@defaults.keys.include?(k) || v == "" }
  @@defaults.merge(@@custom).each do |k,v|
    cattr_accessor k
    attr_accessor k
    self.send("#{k}=", v)
  end

  validates :title, :length => { :minimum => 5 }

  def save
    if self.valid?
      hash = {}
      @@defaults.each do |k,v|
        value = self.send(k)
        puts value.inspect
        puts v.inspect
        value = case v
        when TrueClass, FalseClass
          value.to_i > 0 
        when Symbol
          value.to_sym
        else
          value
        end
        hash[k.to_s] = value if value && value != "" && value != v
      end
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