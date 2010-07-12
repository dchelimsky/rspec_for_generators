require 'test/unit'
require 'rails/all'
require 'rails/generators'
require 'rails/generators/test_case'

require 'rspec_for_generators/rails_spec_helper'

# Call configure to load the settings from
# Rails.application.config.generators to Rails::Generators

Rails::Generators.configure!

# require the generators
def require_generators generator_list
  generator_list.each do |name, generators|
    generators.each do |generator_name|
      require File.join('generators', name.to_s, generator_name.to_s, "#{generator_name}_generator")
    end    
  end
end

module RSpec    
  module Generator
    class << self  
      attr_accessor :generator, :test_method_name

      def run_generator *args, &block
        generator.run_generator *args
        if block
          block.arity < 1 ? generator.instance_eval(&block) : block.call(generator, self)  
        end      
      end

      def check(&block)
        if block
          block.arity < 1 ? self.instance_eval(&block) : block.call(self)  
        end      
      end
    
      def with_generator &block
        with(get_generator, &block)
      end

      def setup_generator test_method_name=nil, &block
        clean! if test_method_name  
        generator = get_generator(test_method_name).extend(RSpec::Generator::Helpers)
        if block
          block.arity < 1 ? generator.class.instance_eval(&block) : block.call(generator.class)  
        end
      end

      protected
      
      def clean!
        if generator
          generator.class.generator_class = nil 
        end
        @generator = nil
      end
    
      def get_generator test_method_name=nil
        @generator ||= RSpec::Generators::TestCase.new(test_method_name + '_spec')
      end
      
    end # class self
  end
end
