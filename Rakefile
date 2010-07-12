begin
  require 'jeweler'
  Jeweler::Tasks.new do |gem|
    gem.name = "rspec_for_generators"
    gem.summary = %Q{RSpec 2 matchers, helpers and utils for writing generator specs}
    gem.description = %Q{RSpec 2 matchers, helpers and utils to assist in writing generator specs}
    gem.email = "kmandrup@gmail.com"
    gem.homepage = "http://github.com/kristianmandrup/rspec_for_generators"
    gem.authors = ["Kristian Mandrup"]
    gem.add_development_dependency "rspec", ">= 2.0.0.beta16"
    gem.add_dependency "rspec",     ">= 2.0.0.beta16"
    gem.add_dependency "rake",      ">= 0.8.7"
    gem.add_dependency "rails",     ">= 3.0.0.beta4" 
    gem.add_dependency "test-unit", ">= 2.0.9"
    # gem is a Gem::Specification... see http://www.rubygems.org/read/chapter/20 for additional settings
  end
  Jeweler::GemcutterTasks.new
rescue LoadError
  puts "Jeweler (or a dependency) not available. Install it with: gem install jeweler"
end

# require 'spec/rake/spectask'
# Spec::Rake::SpecTask.new(:spec) do |spec|
#   spec.libs << 'lib' << 'spec'
#   spec.spec_files = FileList['spec/**/*_spec.rb']
# end
# 
# Spec::Rake::SpecTask.new(:rcov) do |spec|
#   spec.libs << 'lib' << 'spec'
#   spec.pattern = 'spec/**/*_spec.rb'
#   spec.rcov = true
# end
# 
# task :spec => :check_dependencies
# 
# task :default => :spec
# 
# require 'rake/rdoctask'
# Rake::RDocTask.new do |rdoc|
#   version = File.exist?('VERSION') ? File.read('VERSION') : ""
# 
#   rdoc.rdoc_dir = 'rdoc'
#   rdoc.title = "rspec_for_generators #{version}"
#   rdoc.rdoc_files.include('README*')
#   rdoc.rdoc_files.include('lib/**/*.rb')
# end

