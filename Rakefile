# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require "bundler"
Bundler::GemHelper.install_tasks

require File.expand_path('../test_app/config/application', __FILE__)

TestApp::Application.load_tasks

desc 'Rebuild test and run specs'
task :full_test do
  system("rake db:drop db:migrate RAILS_ENV=test && rspec")
end

task :default => 'full_test'
