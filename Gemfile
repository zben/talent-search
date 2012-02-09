source 'http://rubygems.org'

gem 'rails', '3.1.1'
gem 'haml'
gem 'devise'
gem "nifty-generators", :group => :development
# Bundle edge Rails instead:
# gem 'rails',     :git => 'git://github.com/rails/rails.git'
gem 'nested_form',:git => 'git://github.com/ryanb/nested_form.git'


gem 'formtastic',:git => 'https://github.com/justinfrench/formtastic.git'
gem 'formtastic-bootstrap'
gem 'active_hash'
gem "seedbank"
# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails', "  ~> 3.1.0"
  gem 'coffee-rails', "~> 3.1.0"
  gem 'uglifier'
end
gem 'jquery-rails'
gem 'tinymce-rails',:git => 'git://github.com/spohlenz/tinymce-rails.git'
#gem "paperclip", "~> 2.0"
group :development do
  gem 'sqlite3'
end
gem 'mongoid'
gem 'bson_ext'
gem 'mongoid_fulltext'
gem 'simple_enum', :git => 'git://github.com/lwe/simple_enum.git'
gem "mongoid-paperclip", :require => "mongoid_paperclip"
gem "aws-sdk",            :require => "aws/s3"
gem 'thin'
group :production do
  # gems specifically for Heroku go here
  gem "heroku"
  gem "pg"
end
gem "erb2haml", :group => :development
gem "faker"
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
