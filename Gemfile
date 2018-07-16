# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '>= 2.3.0', '< 2.6.0'

gem 'rails', '~> 5.2.0'

gem 'pg', '>= 0.18', '< 2.0'
gem 'puma', '~> 3.12'

gem 'devise'
gem 'pundit'
gem 'kaminari'
gem 'stringex'
gem 'slim-rails'
gem 'carrierwave'
gem 'mini_magick', require: false
gem 'bootstrap-sass', '~> 3.3.3'
gem 'font-awesome-sass', '~> 4.3.0'
gem 'acts-as-taggable-on', github: 'mbleigh/acts-as-taggable-on'
gem 'activerecord-reputation-system', github: 'twitter/activerecord-reputation-system'

gem 'sass-rails', '~> 5.0'
gem 'coffee-rails', '~> 4.2.0'
gem 'uglifier', '>= 1.3.0'
gem 'jquery-rails'
gem 'turbolinks', '~> 5.1.0'
gem 'rails-timeago'
gem 'whenever', require: false
gem 'bootsnap', require: false

group :development do
  gem 'pgreset'
  gem 'letter_opener'
  gem 'better_errors'
  gem 'binding_of_caller'

  gem 'guard-rspec', require: false
  gem 'guard-livereload', require: false

  gem 'spring'
  gem 'spring-commands-rspec'
end

group :development, :test do
  gem 'faker'
  gem 'factory_girl_rails'
  gem 'rspec-rails', '~> 3.7'

  gem 'pry-rails'
  gem 'pry-byebug'
end

group :test do
  gem 'capybara'
  gem 'shoulda-matchers'
end
