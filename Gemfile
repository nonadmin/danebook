source 'https://rubygems.org'
ruby '2.2.1'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.2.1'
# PostgreSQL
gem 'pg'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.1.0'
# See https://github.com/rails/execjs#readme for more supported runtimes
gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'
# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'
# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0', group: :doc

# Use ActiveModel has_secure_password
gem 'bcrypt', '~> 3.1.7'

# Use Unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

gem 'faker'

# Boostrap stuff
gem 'bootstrap-sass'

# Pagination
gem 'will_paginate', '~> 3.0.6'
gem 'will_paginate-bootstrap'

# File Uploads
gem 'paperclip'
gem 'aws-sdk', '< 2.0'
gem 'figaro'
gem 'delayed_paperclip'

# Delayed Jobs
gem 'delayed_job_active_record'
gem 'daemons'

group :development, :test do
  # Testing
  gem 'factory_girl_rails', '~> 4.0'
  gem 'rspec-rails'

  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'hirb'
  gem 'pry-rails'
  gem 'pry-byebug'
  gem 'better_errors'
  gem 'binding_of_caller'

  # Access an IRB console on exception pages or by using <%= console %> in views
  gem 'web-console', '~> 2.0'

  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'

  # Mail testing
  gem 'letter_opener'  
end

group :development do
  gem 'guard-rspec'
end

group :test do
  gem 'shoulda-matchers', '~> 3.0'
  gem 'capybara'
  gem 'launchy'
  gem 'database_cleaner'

end

group :production do
  # Heroku 
  gem 'rails_12factor'
end

