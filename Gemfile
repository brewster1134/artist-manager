source "http://rubygems.org"

gem "rails", "3.1.3"

# Bundle edge Rails instead:
# gem "rails",     :git => "git://github.com/rails/rails.git"

group :production do
  gem 'pg'
end
group :development, :test do
  gem 'sqlite3'
end

gem "activemerchant"
gem "acts-as-taggable-on"
gem "bcrypt-ruby"
gem "carrierwave"
gem "coffee-rails"
gem "gcal4ruby"
gem "haml"
gem "jquery-rails"
gem "mini_magick"
gem "money"
gem "rails3-jquery-autocomplete"
gem "redcarpet", "> 2.0"
gem "simple_form"

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem "sass-rails"
  gem "uglifier"
  gem "compass", '~> 0.12.alpha'
end

# To use debugger
# gem "ruby-debug19", :require => "ruby-debug"

group :development, :test do
  gem 'rspec-rails'
end

# Development
group :development do
  gem "colorize"
  gem "haml-rails"
  gem "lorem"
end

# Testing
group :test do
  gem "turn", :require => false
  gem "capybara"
  gem "factory_girl_rails"
  gem "guard-rspec"
  gem 'guard-spork'
  gem "spork", "> 0.9.0.rc"
end

# For Heroku Production Demo
group :production do
  gem "colorize"
  gem "lorem"
  gem "factory_girl_rails"
end