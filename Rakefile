APP_RAKEFILE = File.expand_path("../test_app/Rakefile", __FILE__)
load APP_RAKEFILE

begin
  require 'rspec/core/rake_task'
  RSpec::Core::RakeTask.new(:spec)
  task :test_with_setup do
    `RAILS_ENV='test' rake db:migrate` 
    Rake::Task[:spec].invoke
  end
  task default: :test_with_setup
rescue LoadError
end


