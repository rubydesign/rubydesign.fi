require "best_in_place"
require "kaminari"
require 'simple_form'

module RubyClerks
  class Engine #< ::Rails::Engine

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

  end
end
