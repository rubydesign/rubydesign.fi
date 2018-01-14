source 'https://rubygems.org'

gemspec

gem 'sqlite3'

gem 'ruby2js'  , git: "https://github.com/rubys/ruby2js"
#gem "ruby2js" , path: ".."

#asset / production related
gem "therubyracer"
gem "libv8"
gem "rb-readline"
gem 'uglifier', '>= 1.3.0'

gem "autoprefixer-rails"

group :development do
  gem 'better_errors'
  gem 'binding_of_caller'
  gem "i18n-tasks" , "0.8.7"
  gem 'spring'
  gem 'spring-commands-rspec'
  gem 'spring-watcher-listen'
end
group :test do
  gem "codeclimate-test-reporter"
  gem 'rspec-rails'
  gem 'capybara'
  gem 'capybara-screenshot'
  gem "poltergeist"
  gem "phantomjs" , :require => 'phantomjs/poltergeist'
  gem 'database_cleaner'
  gem "factory_girl_rails"
  gem 'email_spec'
  gem 'i18n-spec'
  gem 'guard-rails'
  gem 'guard-rspec'
end
