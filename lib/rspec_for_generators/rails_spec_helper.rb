require 'rspec_for_generators/rails_helpers/all'

class TestApp < Rails::Application
  raise StandardError, "You must define a location for Rails.config_root_dir" if !Rails.config_root_dir
  config.root = Rails.config_root_dir
end

module Rails
  def self.root
    raise StandardError, "You must define a location for Rails.config_root_dir" if !Rails.config_root_dir    
    @root ||= File.expand_path(File.join(Rails.config_root_dir, '..', 'tmp', 'rails'))
  end
end

Rails.application = TestApp
Rails.application.config.root = Rails.root

