module RSpec  
  module Rails
    module App 
      def self.debug!
        self.extend(Debug)        
      end      
      
      module Debug
        def rails_files
          FileList["#{::Rails.root}/**/*.rb"]
        end  

        def rails_app_files
          FileList["#{::Rails.root}/app/**/*.rb"]
        end  

        def rails_model_files
          FileList["#{::Rails.root}/app/models/**/*.rb"]
        end  

        def rails_controller_files
          FileList["#{::Rails.root}/app/controllers/**/*.rb"]
        end  

        def rails_helper_files
          FileList["#{::Rails.root}/app/helpers/**/*.rb"]
        end  

        def rails_view_files
          FileList["#{::Rails.root}/app/views/**/*.yml"]
        end

        def rails_initializer_files
          FileList["#{::Rails.root}/config/initializers/**/*.rb"]
        end  

        def rails_migration_files
          FileList["#{::Rails.root}/db/migration/**/*.rb"]
        end

        def rails_locale_files
          FileList["#{::Rails.root}/config/locales/**/*.yml"]
        end

        def rails_javascript_files
          FileList["#{::Rails.root}/public/javascripts/**/*.yml"]
        end

        def rails_stylesheet_files
          FileList["#{::Rails.root}/public/stylesheets/**/*.yml"]
        end
      end
    end
  end
end