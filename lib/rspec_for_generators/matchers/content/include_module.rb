module RSpec
  module RubyContentMatchers
    class IncludeModule

      attr_reader :module_name

      def initialize module_name
        @module_name = module_name
      end

      def matches?(content)      
        @content = content        
        match_res = (@content =~ /include\s+#{module_name}/)
        if block_given? && match_res
          ruby_content = content.extend(RSpec::RubyContent::Helpers)
          yield ruby_content
        else
          match_res
        end
      end          
    
      def failure_message
        "Expected there to be an inclusion of module #{module_name}"
      end 
      
      def negative_failure_message
        "Did not expect there to be an inclusion of module #{module_name}"
      end
                 
    end
    
    def include_module(module_name)
      IncludeModule.new(module_name)
    end    
  end  
end