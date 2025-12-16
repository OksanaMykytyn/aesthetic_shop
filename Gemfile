# Gemfile

source "https://rubygems.org"
ruby "3.2.2"

gem "rails", "~> 7.1.5", ">= 7.1.5.2"
gem "pg", "~> 1.1"
gem "puma", ">= 5.0"
gem "importmap-rails"
gem "turbo-rails"
gem "stimulus-rails"
gem "jbuilder"
gem "sprockets-rails"
gem "bootsnap", require: false

# Authentication / Authorization
gem "devise"
gem "pundit"                

# Payments
gem "stripe"

# Search / friendly urls
gem "pg_search"
gem "friendly_id", "~> 5.5.0"

# Images / ActiveStorage
gem "image_processing", "~> 1.2"

gem "kaminari"
# Frontend
gem "tailwindcss-rails"

# Dev / Test utilities
group :development, :test do
  gem "faker"
  gem "debug", platforms: %i[mri windows]
end

group :development do
  gem "listen", "~> 3.0.5"
end
