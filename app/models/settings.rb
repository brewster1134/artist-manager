require "yaml"
class Settings < ActiveRecord::Base
  CUSTOM_FILE = Rails.root.join("config", "settings_#{Rails.env}.yml")
  after_initialize :create_methods

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
  @@defaults.keys.each { |attr| attr_accessor attr }

  validates :title, :length => { :minimum => 5 }

  if @@custom = YAML::load(File.open(CUSTOM_FILE, 'r'))
    @@custom.delete_if{ |k,v| !@@defaults.keys.include?(k) || v == "" }
  else
    {}
  end
  @@settings = @@defaults.merge(@@custom)

  def self.method_missing(method, *args)
    if @@defaults.keys.include? method.to_s
      self.new.send(method)
    else
      super
    end
  end

  def save
    if self.valid?
      hash = {}
      @@defaults.each do |k,v|
        value = self.send(k)
        case v
        when TrueClass, FalseClass then value = value.to_i > 0 
        when Symbol then value = value.to_sym 
        end
        hash[k.to_s] = value unless value == "" || value == v
      end
      File.open(CUSTOM_FILE, 'w+') { |f| f.write hash.to_yaml }
    end
  end

  def create_methods
    @@settings.each do |k,v|
      self.send("#{k}=", v) if self.send(k).nil?
    end
  end
  private :create_methods
  
end