APP_RAKEFILE = File.expand_path("../test_app/Rakefile", __FILE__)
load APP_RAKEFILE

begin
  require 'rspec/core/rake_task'
  RSpec::Core::RakeTask.new(:spec)
  task default: :spec
rescue LoadError
end


