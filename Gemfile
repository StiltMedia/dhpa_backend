source 'https://rubygems.org'

gem 'rails', '4.2.3'

gem 'pg'

gem 'sass-rails', '~> 5.0'
gem 'devise'
gem "haml-rails", "~> 0.9"
gem "figaro"
gem "font-awesome-rails"
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.1.0'
gem 'friendly_id', '~> 5.1.0' # Note: You MUST use 5.0.0 or greater for Rails 4.0+
gem 'acts-as-taggable-on', '~> 3.4'
gem 'textacular', '~> 3.0' # Search

gem 'jquery-rails'
gem 'jquery-ui-rails'
gem 'turbolinks'
gem 'jquery-turbolinks'

gem 'mail_form'

gem 'stripe', '~> 1.31.0'

# Refile for attachments and image upload/thumbnailing
gem "refile", require: "refile/rails"
gem "refile-mini_magick", '~> 0.2.0'
gem "refile-s3", '~> 0.2.0'

# MiniExiftool for extracting EXIF info (includes Exiftool application)
gem 'mini_exiftool_vendored'

# Use Unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'pry'
  gem 'byebug'

  # Access an IRB console on exception pages or by using <%= console %> in views
  gem 'web-console', '~> 2.0'

  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'

  # Easier to set environment variables on a per-project basis
  gem 'dotenv-rails'

  # Easier to debug
  gem "better_errors"
  gem "binding_of_caller"

  # Test db
  gem 'sqlite3'
end

