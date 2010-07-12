# Asserts a given file exists. You need to supply an absolute path or a path relative
# to the configured destination:
#
#   generator.should have_generated_file "app/controller/products_controller.rb" 
#            

module RSpec
  module FileMatchers
    class GenerateFile

      def initialize(relative_path, type = nil)
        @relative_path = relative_rails_file relative_path, type
      end

      def matches?(generator, &block)              
        @expected = File.expand_path(@relative_path, generator.class.destination_root)
        ex = File.exists?(@expected)
        if block && ex
          read = File.read(@expected)
          ruby_content = read.extend(RSpec::RubyContent::Helpers)
          yield ruby_content
        else
          ex
        end        
      end          
    
      def failure_message
        "Expected file #{@relative_path} to have been generated, but it was not"
      end

      def negative_failure_message
        "Did not expected file #{@relative_path} to have been generated, but it was"
      end
      
      protected
      
      def relative_rails_file path, type = nil                             
        return File.join(::Rails.root, base_dir(type), folder(type), "#{path.to_s}.rb") if type        
        File.join(::Rails.root, path)
      end

      def folder type
        case type
        when :observer
          'models'
        else
          type.to_s.pluralize
        end
      end      
      
      def base_dir type
        case type
        when :model, :controller, :view, :helper, :observer
          'app'
        when :migration
          'db'
        when :javascript, :stylesheet
          'public'
        when :initializer, :locale
          'config'
        else
          ''          
        end
      end
    end

    def generate_file(relative, type = nil)
      GenerateFile.new(relative, type)
    end
    alias_method :generate_directory, :generate_file  

  end
end
