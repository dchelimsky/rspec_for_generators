module RSpec         
  module Generators
    class TestCase < ::Rails::Generators::TestCase   
      setup :prepare_destination
      destination File.join(::Rails.root)      
            
      def initialize(test_method_name)
        @method_name = test_method_name
        @test_passed = true
        @interrupted = false
        routes_file = File.join(File.dirname(__FILE__), 'fixtures', 'routes.rb')        
        copy_routes routes_file
      end 
      
      def copy_routes routes_file        
        routes = File.expand_path(routes_file)
        raise ArgumentError, "No routes file exists at #{routes_file}" if !File.exist?(routes)
        destination = File.join(::Rails.root, "config")
        FileUtils.mkdir_p(destination)
        FileUtils.cp routes, destination
      end
           
    end
  end
end
