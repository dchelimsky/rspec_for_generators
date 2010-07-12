# This method tries to see if a specific method is contained in the generated file.
# It can operate (should) on either a file name or the raw content 
#
#   generated_file_name.should have_method "hello" # 'my/path/say_hello.rb'.should have_method "hello"
#
#   say_hello_file_content.should have_method "hello"
#
module RSpec
  module RubyContentMatchers
    class HaveMethod

      attr_reader :method

      def initialize(method, type)
        @type = type
        @method = method
      end

      def matches?(content)      
        @content = content
        case @type
        when :class
          @content =~ /def\s+self.#{method}\s*(\(.+\))?(.*?)/m
        else
          @content =~ /def\s+#{method}\s*(\(.+\))?(.*?)/m
        end
      end          
    
      def failure_message
        return "Expected there to be the class method #{method}, but there wasn't" if @type == :class
        "Expected there to be the method #{method}, but there wasn't"        
      end 
      
      def negative_failure_message                                      
        return "Did not expect there to be the method #{method}, but there was" if @type == :class
        "Did not expect there to be the method #{method}, but there was"
      end
                 
    end
    
    def have_method(method, type = nil)
      HaveMethod.new(method, type)
    end
    alias_method :have_instance_method, :have_method 
    
  end  
end


