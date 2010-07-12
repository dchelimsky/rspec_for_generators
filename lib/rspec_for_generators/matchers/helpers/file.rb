module RSpec
  module Generator
    module Helpers
      def check_file file, type=nil, &block
        self.should generate_file(file, type, &block)
      end
      alias_method :file, :check_file

      def check_view(file_name, matchings)
        self.should generate_file(filename, :view) do |content|  
          check_matchings matchings
        end
      end
      alias_method :view, :check_view

      def check_model(name, clazz, options = {})
        self.should generate_file("#{name.underscore}.rb", :model) do |file_content|
          file_content.should have_class clazz.camelize do |content|
            check_matchings options[:matchings]    
            check_methods(options[:methods])
            check_class_methods(options[:class_methods])
          end
        end            
      end
      alias_method :model, :check_model
    end
  end
end