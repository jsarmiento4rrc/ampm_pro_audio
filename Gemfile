source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "3.1.2"

# Bundle edge Rails instead: gem "rails", github: "rails/rails", branch: "main"
gem "rails", "~> 7.0.10"

# The original database the project was created with
gem "sqlite3", "~> 1.4"

# Use the Puma web server [Requirement 5.8]
gem "puma", "~> 5.0"

# Use JavaScript import maps [Requirement 4.1.4]
gem "importmap-rails"

# Hotwire's SPA-like page accelerator [Requirement 2.2.2]
gem "turbo-rails"
gem "stimulus-rails"

# Build JSON APIs with ease
gem "jbuilder", "~> 2.7"

# Use Redis adapter to run Action Cable in production
# gem "redis", "~> 4.0"

# Use Kaminari for pagination [Requirement 2.5]
# Note: ActiveAdmin also depends on this, so we list it once here.
gem "kaminari"

# Use ActiveAdmin for the dashboard [Requirement 1.1]
gem "activeadmin"

# Use Devise for user authentication [Requirement 3.1.4]
gem "devise"

# Stripe for payment processing [Requirement 3.3.1]
gem "stripe"

# Faker for generating realistic seed data [Requirement 1.6]
gem "faker"

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem "tzinfo-data", platforms: %i[ mswin mingw x64_mingw jruby ]

# Use SCSS for styling [Requirement 4.1.5]
gem "sassc-rails"

# Reduces boot times through caching; list this before any gems that use it
gem "bootsnap", require: false

group :development, :test do
  # See https://guides.rubyonrails.org/debugging_rails_applications.html#debug-with-the-debug-gem
  gem "debug", platforms: %i[ mri mingw x64_mingw ]
end

group :development do
  # Speed up development by caching unchanged dependencies.
  gem "web-console"

  # Display performance information such as SQL queries and stack traces.
  gem "rack-mini-profiler"

  # Annotate Models with schema information
  gem "annotate"
end

group :test do
  # Use system testing [Requirement 5.5]
  gem "capybara"
  gem "selenium-webdriver"
end