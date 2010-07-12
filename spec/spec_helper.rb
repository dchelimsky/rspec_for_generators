require 'rspec/autorun'
require 'rails/generators'

module Rails
  class << self
    attr_accessor :config_root_dir
  end
end

Rails.config_root_dir = File.expand_path('../../tmp/app/config', __FILE__)

require 'rspec_for_generators'

RSpec.configure do |config|
  
end
