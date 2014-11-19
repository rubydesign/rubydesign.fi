# coding: utf-8
$:.push File.expand_path("../lib", __FILE__)

require "office_clerk/version"

Gem::Specification.new do |s|
  s.platform     = Gem::Platform::RUBY
  s.name         = 'office_clerk'
  s.version      = OfficeClerk::VERSION
  s.summary      = 'Backend of rubyclerks, a simple way to manage a buisness'
  s.description  = "Rubyclerks is a small buisness management solution, including an online presence (shop), but also POS, inventory and more."
  s.required_ruby_version = '>= 1.9.3'

  s.authors      = ['Torsten Rüger']
  s.email        = ['torsten@villataika.fi']
  s.homepage     = 'https://github.com/rubyclerks/office_clerk'
  s.license      = 'MIT'

  s.files        = `git ls-files`.split("\n")
  s.test_files   = `git ls-files -- spec/*`.split("\n")
  s.require_path = 'lib'
  s.requirements << 'none'

  s.has_rdoc = false

  s.add_runtime_dependency 'rails', '~> 4.0', '>= 4.0.1'
  s.add_runtime_dependency 'sass-rails' , '~> 4.0'
  s.add_runtime_dependency "haml" , '~> 4.0'
  s.add_runtime_dependency "opal-rails" , '~> 0.6'
  s.add_runtime_dependency 'opal-jquery' , '~> 0.2'

  s.add_runtime_dependency 'jquery-ui-rails' , '~> 5.0'
  s.add_runtime_dependency "kramdown" , '~> 1.5'

  s.add_runtime_dependency 'simple_form' , '~> 3.0'
  s.add_runtime_dependency 'will_paginate-bootstrap' , '~> 1.0'
  s.add_runtime_dependency 'bootstrap-sass', '~> 3.1'
  s.add_runtime_dependency 'bootstrap_form' , '~> 2.2'
  s.add_runtime_dependency "paperclip" , '~> 4.1'
  s.add_runtime_dependency 'rails-i18n' , '~> 4.0'

  s.add_runtime_dependency "bcrypt-ruby" , '~> 3.1'

  #these will stil have to go to accountant
  s.add_runtime_dependency "barby"
  s.add_runtime_dependency "chunky_png"
  s.add_runtime_dependency "prawn"

end
