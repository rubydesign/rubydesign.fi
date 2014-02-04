source 'https://rubygems.org'
ruby '2.0.0'

gem 'rails'
gem 'sqlite3'

#ui
gem 'sass-rails'
gem 'jquery-rails'
gem 'jquery-ui-rails'

# template
gem 'simple_form' 
gem "haml"
gem "will_paginate"
gem "ransack", github: "activerecord-hackery/ransack", branch: "rails-4"
gem "prawn"
gem 'will_paginate-bootstrap'
gem 'bootstrap-sass', '~> 3.1.0'

gem "paperclip"
gem 'turbolinks'
gem 'rails-i18n'

gem "barby"
gem "chunky_png"
gem "bcrypt-ruby"

#misc
gem "valid_email" , :require => 'valid_email/email_validator' #no mx checking

#asset / production reelated
gem "therubyracer" 
gem "libv8" , "3.16.14.3"
gem "rb-readline"
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails'

#one wishes one would not need it. alas . . .
gem 'rack-attack'

group :development do
  gem "migrate_spree", :path => "../migrate_spree"
  gem 'db_fixtures_dump'
  gem 'better_errors'
  gem 'binding_of_caller', :platforms=>[:mri_19, :mri_20, :rbx]
  gem 'guard-bundler'
  gem 'guard-rails'
  gem 'guard-rspec'
  gem "i18n-tasks"
  gem 'quiet_assets'
  gem 'rails_layout'
#  gem "jeweler", "> 1.6.4"
end
group :development, :test do
  gem 'factory_girl_rails'
  gem 'rspec-rails'
end
group :test do
#  gem "poltergeist"
#  gem "phantomjs"
  gem 'capybara'
  gem 'database_cleaner', '1.0.1'
  gem 'email_spec'
end

