module RSpec
  module RubyContentMatchers
    class HaveClass

      attr_reader :klass

      def initialize(klass)
        @klass = klass      
      end

      def matches?(content)      
        @content = content
        match_res = (@content =~ /class\s+#{@klass}\s+(.*)end/m)
        if block_given? && $1
          ruby_content = $1.strip.extend(RSpec::RubyContent::Helpers)
          yield ruby_content 
        else
          match_res
        end
      end          
    
      def failure_message
        "Expected there to be the class #{klass}"
      end 
      
      def negative_failure_message
        "Did no expected there to be the class #{klass}"
      end
                 
    end
    
    def have_class(klass)
      HaveClass.new(klass)
    end    
  end  
end