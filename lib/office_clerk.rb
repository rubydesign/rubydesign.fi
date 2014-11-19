require "office_clerk/engine"

require "haml"
require "jquery-ui-rails"
require "kramdown"
require "will_paginate"

require 'simple_form' 
require "prawn"
require 'will_paginate-bootstrap'
require 'bootstrap-sass'
require 'bootstrap_form'
require "paperclip"
require 'rails-i18n'

require "barby"
require "chunky_png"
require "bcrypt"
require "opal"
require "opal/rails"

require "office_clerk/shipping_method"

module OfficeClerk
  # Configuration is stored in locale/config.yml under the main key (ie "locale") config
  # You can add to it, or redifine it, just like you do to locale data, by adding a locale file to your app
  #  with config locale and the keys you need   
  def self.config key
    I18n.t(key , :locale => :config)
  end
end