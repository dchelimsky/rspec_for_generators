require 'rspec'
require 'rake'
require 'rspec_for_generators/rails_spec_helper'
require 'rspec_for_generators/rspec_test_case'
require 'rspec_for_generators/generator_spec_helper'
require 'rspec_for_generators/matchers/content/all'
require 'rspec_for_generators/matchers/file/all'

RSpec.configure do |config|
  config.include(RSpec::FileMatchers)
  config.include(RSpec::RubyContentMatchers)  
end
