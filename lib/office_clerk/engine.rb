require "best_in_place"

module OfficeClerk
  class Engine < ::Rails::Engine
    engine_name "office"

    config.autoload_paths += %W(#{config.root}/lib)
#    config.assets.paths +=
    config.exceptions_app = self.routes
    initializer "office_clerk.assets.precompile" do |app|
      app.config.assets.precompile += %w(office_clerk.css office_clerk.js office_clerk/*.jpg missing*.png)
    end

    config.i18n.enforce_available_locales = false
    config.i18n.available_locales = [:fi , :en , :config]
    config.i18n.default_locale = :fi
    # for testing this makes engine factories available
    initializer "model_core.factories", :after => "factory_girl.set_factory_paths" do
      FactoryGirl.definition_file_paths << File.expand_path('../../../spec/factories', __FILE__) if defined?(FactoryGirl)
    end

    # have to init the BestInPlace first to be able to include helpers
    config.railties_order = [BestInPlace::Railtie , OfficeClerk::Engine  , :all  ]
    config.after_initialize do
      BestInPlace::ViewHelpers.extend OfficeHelper
    end

  end
end
