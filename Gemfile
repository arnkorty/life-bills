if ENV['SSH_CLIENT'] || ENV['TRAVIS']
	source 'https://rubygems.org'
else
	source 'http://ruby.taobao.org'
end

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.0.0'


# Use SCSS for stylesheets
gem 'sass-rails', '~> 4.0.0'

# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'

# Use CoffeeScript for .js.coffee assets and views
gem 'coffee-rails', '~> 4.0.0'

gem 'bootstrap-sass','~> 3'
gem 'bootstrap-datepicker-rails'

# gem "therubyracer"
# See https://github.com/sstephenson/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'

# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 1.2'
gem 'devise'
gem 'kaminari'
# gem 'twitter-bootstrap-rails'
gem 'cancan'
gem 'simple_form'
gem 'mongoid', github:"mongoid/mongoid"

gem 'settingslogic'
# gem 'haml-rails'
gem 'slim-rails'

group :doc do
  # bundle exec rake doc:rails generates the API under doc/api.
  gem 'sdoc', require: false
end


group :development,:test do
	gem 'pry-rails'
	gem 'better_errors'
	gem "binding_of_caller"
	gem 'rack-mini-profiler'
	gem 'capistrano', '~> 3.0.1'
	gem 'capistrano-rvm', '~> 0.0.3'	
end

group :test do
	gem 'capybara'
	gem 'database_cleaner'
	gem 'rspec-rails'
	gem 'factory_girl_rails'
	gem 'cucumber-rails',require:false
	gem 'email_spec'
	gem 'launchy'	
end
# Use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.0.0'

# Use unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano', group: :development

# Use debugger
gem 'debugger', group: [:development, :test]
# Use puma as web server
gem 'puma'
