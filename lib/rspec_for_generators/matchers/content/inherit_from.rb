module RSpec
  module RubyContentMatchers
    class InheritFrom

      attr_reader :klass

      def initialize(content)
        @klass = klass
      end

      def matches?(content)      
        @content = content
        @content =~ /class\s+(.*?)<\s+#{klass}(.*)end/
        if block_given?
          ruby_content = $2.strip.extend(RSpec::RubyContent::Helpers)
          yield ruby_content
        end
      end          
    
      def failure_message
        "Expected the class to inherit from #{klass}"
      end 
      
      def negative_failure_message
        "Did not expect the class to inherit from #{klass}"
      end
    end
    
    def inherit_from(klass)
      InheritFrom.new(klass)
    end    
  end  
end