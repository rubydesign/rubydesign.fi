require File.expand_path('../boot', __FILE__)

# Pick the frameworks you want:
require "active_record/railtie"
require "action_controller/railtie"
require "action_mailer/railtie"
require "sprockets/railtie"
# require "rails/test_unit/railtie"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(:default, Rails.env)

module OfficeClerk
  class Application < Rails::Application
    config.autoload_paths += %W(#{config.root}/app/modules)

    # don't generate RSpec tests for views and helpers
    config.generators do |g|

      g.test_framework :rspec, fixture: true
      g.fixture_replacement :factory_girl, dir: 'spec/factories'


      g.view_specs false
      g.helper_specs false
    end
    I18n.enforce_available_locales = false
    I18n.default_locale = :fi
    config.after_initialize do
    end
    config.middleware.use Rack::Attack
    config.paperclip_defaults =  {  :styles => {:thumb => '48x48>', :list => '150x150>', :product  => '600x600>' },
                                :default_style => :list,
                                :url => "/images/:id/:style/:basename.:extension",
                                :default_url => "/images/missing/:style.png"      }

    # FOG example see more in paperclip docs  {:storage => :fog, :fog_credentials => {:provider => "Local", :local_root => "#{Rails.root}/public"}, :fog_directory => "", :fog_host => "localhost"}

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    # config.time_zone = 'Central Time (US & Canada)'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    # config.i18n.default_locale = :de
  end
end
