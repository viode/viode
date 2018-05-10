source 'https://rubygems.org'

# sets ruby version
# ex: VIODE_RUBY_VERSION=2.2.2
if ENV['VIODE_RUBY_VERSION']
  ruby ENV['VIODE_RUBY_VERSION']
end

gem 'rails', '5.2.0'

gem 'pg'

gem 'devise'
gem 'pundit'
gem 'kaminari'
gem 'stringex'
gem 'slim-rails'
gem 'carrierwave'
gem 'mini_magick', require: false
gem 'bootstrap-sass', '~> 3.3.3'
gem 'font-awesome-sass', '~> 5.0.9'
gem 'acts-as-taggable-on', '~> 5.0', github: 'Fodoj/acts-as-taggable-on', branch: 'rails-5.2'
gem 'activerecord-reputation-system', github: 'twitter/activerecord-reputation-system'

gem 'sass-rails', '~> 5.0'
gem 'coffee-rails', '~> 4.2.0'
gem 'uglifier', '>= 1.3.0'
gem 'jquery-rails'
gem 'turbolinks', github: 'rails/turbolinks'
gem 'jquery-turbolinks'
gem 'rails-timeago'
gem 'whenever', :require => false
gem 'bootsnap', :require => false

group :development do
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
