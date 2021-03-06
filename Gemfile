source 'https://rubygems.org'


# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.2.0'
# Use mysql as the database for Active Record
gem 'mysql2'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'

gem 'bootstrap-sass', '~> 3.3.1'
gem 'autoprefixer-rails'

# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.1.0'
# See https://github.com/sstephenson/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'
# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'
# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0', group: :doc
gem 'rails_config'

# Use ActiveModel has_secure_password
gem 'bcrypt', '~> 3.1.7'

group :development do
  gem 'quiet_assets'
  gem 'letter_opener'

  gem 'capistrano', '~> 3.2.0'
  gem 'capistrano-rails'
  gem 'capistrano-rbenv'
  gem 'capistrano-bundler', '~> 1.1.2'
  gem 'capistrano-gitflow', git: "https://github.com/YotpoLtd/capistrano-gitflow.git"
end

# Use Unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug'

  # Access an IRB console on exception pages or by using <%= console %> in views
  gem 'web-console', '~> 2.0'
end

# group :development, :test do
#   gem 'rspec'
#   gem 'rspec-rails'
#   gem 'rb-fsevent', require: false
#   gem 'guard-rspec'
#   gem 'capybara'
#   gem 'launchy'
# end

group :development, :test do
  gem 'rspec-rails'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-commands-rspec'
  gem 'factory_girl_rails', '~> 4.0'
  gem 'shoulda-matchers'
  # gem 'vcr'
  # gem 'autotest-rails'
  gem 'rspec-autotest'
  gem 'capybara'
  gem 'capybara-webkit'
  # gem 'rack_session_access'
  gem 'forgery'
end

group :test do
  gem 'webmock'
  gem 'database_cleaner'
  gem 'timecop'
  # gem 'rspec-json_matcher'
  gem 'rspec-collection_matchers'
end
