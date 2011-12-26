source 'http://rubygems.org'

gem 'rails', '3.1.0'
gem 'haml'
gem 'devise'
gem "nifty-generators", :group => :development
# Bundle edge Rails instead:
# gem 'rails',     :git => 'git://github.com/rails/rails.git'
gem 'nested_form',:git => 'git://github.com/ryanb/nested_form.git'

gem 'formtastic'
gem 'active_hash'
# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails', "  ~> 3.1.0"
  gem 'coffee-rails', "~> 3.1.0"
  gem 'uglifier'
end
gem 'jquery-rails'
group :development do
  gem 'sqlite3'
end
group :production do
  # gems specifically for Heroku go here
  gem "pg"
end
gem 'thin'
gem 'heroku'

# Use unicorn as the web server
# gem 'unicorn'

# Deploy with Capistrano
# gem 'capistrano'

# To use debugger
# gem 'ruby-debug19', :require => 'ruby-debug'

group :test do
  # Pretty printed test output
  gem 'turn', :require => false
end
gem "mocha", :group => :test
