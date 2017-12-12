source 'https://rubygems.org'

gem "office_clerk" , :path => "../"

gem 'sqlite3'

#asset / production reelated
gem "therubyracer"
gem "libv8"
gem "rb-readline"
gem 'uglifier', '>= 1.3.0'

# those guys dropped 1.9 support, but i haven't
gem "autoprefixer-rails" , '< 6.0' , :platform => [:ruby_19]

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
