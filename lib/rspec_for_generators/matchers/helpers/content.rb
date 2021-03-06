module RSpec
  module RubyContent
    module Helpers
      def check_matchings matchings
        matchings.each do |matching|
          self.should match /#{Regexp.escape(matching)}/
        end
      end
      alias_method :matchings, :check_matchings 


      def check_methods methods, type=nil
        methods.each do |method_name|
          self.should have_method(method_name, type)
        end
      end
      alias_method :class_methods, :check_class_methods
    end
  end
end