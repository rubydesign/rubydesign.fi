if ENV['CODECLIMATE_REPO_TOKEN']
  require "codeclimate-test-reporter"
  CodeClimate::TestReporter.start
end

# This file is copied to spec/ when you run 'rails generate rspec:install'
ENV["RAILS_ENV"] = 'test'
require File.expand_path("../../test_app/config/environment",  __FILE__)
Rails.backtrace_cleaner.remove_silencers!

require 'rspec/rails'

Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each { |f| require f }


RSpec.configure do |config|
  
  config.include PageHelper  
  
  config.include OfficeClerk::Engine.routes.url_helpers

  config.infer_base_class_for_anonymous_controllers = false
  config.infer_spec_type_from_file_location!
  
  # Run specs in random order to surface order dependencies. If you find an
  # order dependency and want to debug it, you can fix the order by providing
  # the seed, which is printed after each run.
  #     --seed 1234
  config.order = "random"

  if config.files_to_run.one?
    config.default_formatter = 'doc'
  end

  # Print the 10 slowest examples and example groups at the end of the spec run, 
  #to help surface which specs are running  particularly slow.
#  config.profile_examples = 10
end
