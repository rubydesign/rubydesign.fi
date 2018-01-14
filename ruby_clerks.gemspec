# coding: utf-8
$:.push File.expand_path("../lib", __FILE__)

Gem::Specification.new do |s|
  s.platform     = Gem::Platform::RUBY
  s.name         = 'ruby_clerks'
  s.version      = "2.0"
  s.summary      = 'Rubyclerks: a simple way to manage a buisness'
  s.description  = "Rubyclerks is a small buisness management solution including inventory and more."
  s.required_ruby_version = '>= 2.2'

  s.authors      = ['Torsten Rüger']
  s.email        = ['torsten@villataika.fi']
  s.homepage     = 'https://github.com/dancinglightning/ruby_clerks'
  s.license      = 'MIT'

  s.files        = `git ls-files`.split("\n")
  s.test_files   = `git ls-files -- spec/*`.split("\n")
  s.require_path = 'lib'
  s.requirements << 'none'

  s.has_rdoc = false

  s.add_runtime_dependency 'ruby2js' , '~> 2.1.24'
  s.add_runtime_dependency 'rails', '~> 5.0', '< 5.1'
  s.add_runtime_dependency 'ransack', '~> 1.7'
  s.add_runtime_dependency "valid_email" ,  '~> 0.0', '>= 0.0.10'
  s.add_runtime_dependency 'susy' , '~> 2.0'
  s.add_runtime_dependency 'sass-rails' , '~> 5.0'
  s.add_runtime_dependency "haml" , '~> 4.0'
  s.add_runtime_dependency "jquery-rails" , '~> 4.0'
  s.add_runtime_dependency 'coffee-rails' , '~> 4.0'
  s.add_runtime_dependency 'jquery-ui-rails' , '~> 5.0'
  s.add_runtime_dependency "kramdown" , '~> 1.5'
  s.add_runtime_dependency "best_in_place" , '~> 3.0'
  s.add_runtime_dependency "rabl" , '~> 0.13.1'

  s.add_runtime_dependency 'kaminari' , '~> 1.1'
  s.add_runtime_dependency 'bootstrap', '~> 4.0.beta3'
  s.add_runtime_dependency 'simple_form' , '~> 3.5'
  s.add_runtime_dependency "paperclip" , '~> 4.0'
  s.add_runtime_dependency 'rails-i18n' , '~> 4.0'
  s.add_runtime_dependency 'flot-rails', '0.0.6'
  s.add_runtime_dependency "bcrypt-ruby" , '~> 3.1'
  s.add_runtime_dependency "barby" , "~> 0.6"
  s.add_runtime_dependency "chunky_png" , "~> 1.3"
  s.add_runtime_dependency "prawn" ,  "~> 2.0"
  s.add_runtime_dependency "reference_number"

end
