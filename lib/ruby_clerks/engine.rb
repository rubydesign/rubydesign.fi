require "best_in_place"
require "vuejs-rails"
require "kaminari"

module RubyClerks
  class Engine < ::Rails::Engine
    engine_name "office"

    config.eager_load_paths += %W(#{config.root}/lib)
#    config.assets.paths +=
    config.exceptions_app = self.routes

    config.i18n.enforce_available_locales = false
    config.i18n.available_locales = [:fi , :en , :config]
    config.i18n.default_locale = :fi
    # for testing this makes engine factories available
    initializer "model_core.factories", :after => "factory_girl.set_factory_paths" do
      FactoryGirl.definition_file_paths << File.expand_path('../../../spec/factories', __FILE__) if defined?(FactoryGirl)
    end
    config.assets.precompile += %w( ruby_clerks.css ruby_clerks.js report.js flot.js)
    config.assets.precompile += %w( ruby_clerks/*.jpg  up-icon.png down-icon.png receipt-logo.gif)
    config.assets.precompile += %w(missing_thumb.png missing.png missing_list.png missing_product.png)
    config.assets.precompile += %w(plus.png minus.png)

    # have to init the BestInPlace first to be able to include helpers
    config.railties_order = [BestInPlace::Railtie , RubyClerks::Engine  , :all  ]
    config.after_initialize do
      BestInPlace::ViewHelpers.extend OfficeHelper
    end

  end
end
