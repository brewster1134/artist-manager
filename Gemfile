source "http://rubygems.org"

gem "rails", "3.1.0.rc5"

# Bundle edge Rails instead:
# gem "rails",     :git => "git://github.com/rails/rails.git"

gem "sqlite3"

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem "sass-rails", "~> 3.1.0.rc"
  gem "coffee-rails", "~> 3.1.0.rc"
  gem "uglifier"
  gem "compass", :git => "git://github.com/chriseppstein/compass.git", :branch => "rails31"
end

gem "haml"
gem "jquery-rails"
gem "money"
gem "redcarpet"
gem "settingslogic"
gem "simple_form"

# To use debugger
# gem "ruby-debug19", :require => "ruby-debug"

# Development
group :development do
  gem "colorize"
  gem "haml-rails"
  gem "lorem"
end

# Testing
gem "rspec-rails", group: [:test, :development]
gem "factory_girl_rails", group: [:test, :development]
group :test do
  gem "turn", :require => false
  gem "capybara"
  gem "guard-rspec"
  gem 'guard-spork'
  gem "spork", "0.9.0.rc9"
end
