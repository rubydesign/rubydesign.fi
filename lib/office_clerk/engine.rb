module OfficeClerk
  class Engine < ::Rails::Engine
    engine_name "office"

    config.autoload_paths += %W(#{config.root}/lib)
#    config.assets.paths += 
    config.exceptions_app = self.routes
    initializer "office_clerk.assets.precompile" do |app|
      app.config.assets.precompile += %w(office_clerk.css office_clerk.js)
    end

    I18n.enforce_available_locales = false
    I18n.default_locale = :fi
    config.after_initialize do
      BestInPlace::ViewHelpers.extend OfficeHelper
    end
    # for testing this makes engine factories available
    initializer "model_core.factories", :after => "factory_girl.set_factory_paths" do
       FactoryGirl.definition_file_paths << File.expand_path('../../../spec/factories', __FILE__) if defined?(FactoryGirl)
     end

    config.paperclip_defaults =  {  :styles => {:thumb => '48x48>', :list => '150x150>', :product  => '600x600>' },
                                :default_style => :list,
                                :url => "/images/:id/:style/:basename.:extension",
                                :default_url => "/images/missing/:style.png"      }
  end
end
