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
  s.add_runtime_dependency 'sass-rails'
  s.add_runtime_dependency "haml"
  s.add_runtime_dependency "jquery-rails"
  s.add_runtime_dependency 'jquery-ui-rails'
  s.add_runtime_dependency "kramdown"
  s.add_runtime_dependency "will_paginate"

  s.add_runtime_dependency 'simple_form' 
  s.add_runtime_dependency "prawn"
  s.add_runtime_dependency 'will_paginate-bootstrap'
  s.add_runtime_dependency 'bootstrap-sass', '~> 3.1.0'
  s.add_runtime_dependency 'bootstrap_form'
  s.add_runtime_dependency "paperclip"
  s.add_runtime_dependency 'turbolinks'
  s.add_runtime_dependency 'rails-i18n'

  s.add_runtime_dependency "barby"
  s.add_runtime_dependency "chunky_png"
  s.add_runtime_dependency "bcrypt-ruby"

end
