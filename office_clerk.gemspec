# coding: utf-8
lib = File.expand_path('../lib/', __FILE__)
$LOAD_PATH.unshift lib unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |s|
  s.platform     = Gem::Platform::RUBY
  s.name         = 'office_clerk'
  s.version      = "0.0.1"
  s.summary      = 'Backend of rubyclerks'
  s.description  = s.summary
  s.required_ruby_version = '>= 1.9.3'

  s.authors      = ['Torsten Rüger']
  s.email        = ['torsten@villataika.fi']
  s.homepage     = 'https://github.com/ruby_clerks/office_clerk'
  s.license      = 'MIT'

  s.files        = `git ls-files`.split("\n")
  s.test_files   = `git ls-files -- spec/*`.split("\n")
  s.require_path = 'lib'
  s.requirements << 'none'

  s.has_rdoc = false

  s.add_runtime_dependency 'rails', '~> 4.0.1'

  s.add_development_dependency 'rspec', '~> 3.1.0'
  s.add_development_dependency 'rspec-rails', '~> 3.1.0'
  s.add_development_dependency 'factory_girl', '>= 4.4'
  s.add_development_dependency 'sqlite3', '~> 1.3.9'
  s.add_development_dependency 'simplecov', '~> 0.9.0'
  s.add_development_dependency 'coveralls', '>= 0.7.0'
  s.add_development_dependency 'i18n-spec', '>= 0.5.1'
  s.add_development_dependency 'ffaker', '>= 1.24'
  s.add_development_dependency 'coffee-rails', '~> 4.0.0'
  s.add_development_dependency 'sass-rails', '~> 4.0.0'
  s.add_development_dependency 'pry-rails', '>= 0.3.2'
  s.add_development_dependency 'database_cleaner', '1.3.0'
  s.add_development_dependency 'guard-rspec', '>= 4.2.8'
  s.add_development_dependency 'guard-rubocop', '>= 1.1.0'
  s.add_development_dependency 'rubocop'
end
