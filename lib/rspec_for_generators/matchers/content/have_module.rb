module RSpec
  module RubyContentMatchers
    class HaveModule

      attr_reader :module_name

      def initialize(content)
        @content = content      
      end

      def matches?(module_name)      
        @module_name = module_name
        @content =~ /module\s+#{@module_name}\s+(.*)end/m
        if block_given?
          ruby_content = $2.strip.extend(RSpec::RubyContent::Helpers)
          yield ruby_content
        end
      end          
    
      def failure_message
        "Expected there to be the module #{module_name}"
      end 
      
      def negative_failure_message
        "Did no expected there to be the module #{module_name}"
      end
                 
    end
    
    def have_module(module_name)
      HaveModule.new(module_name)
    end    
  end  
end