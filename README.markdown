# RSpec 2 for generators

RSpec 2 matchers, helpers and various utilities to assist in writing generator specs especially Rails 3 generators.

This project was extracted from my experiments with creating generators for jnunemaker's *Canable*, see [My fork of Canable](http://github.com/kristianmandrup/canable).

I attempted to test the generators I built but I noticed, that the only option I could find, was to use a special Rails TestCase class created for Test-Unit. 
So I thought I could wrap it to be used with RSpec 2; my BDD testing framework of choice!

## Install

In the near future:
<code>gem install rspec_for_generators</code>

For now, just clone this project and run 

<code>rake install</code>

## Usage

The following demonstrates an example usage. There are many more options and cool DSL convenience methods. Check out the code!

<pre>
# spec/spec_helper.rb
require 'rspec'

# load this rspec toolbox to help spec generators
require 'rspec_for_generators' 

RSpec.configure do |config|
  # configure rspec
  config.mock_with :mocha  
end       
<pre>
  
<pre>
  # spec/generators/canable.rb
  require_generators :canable => ['model', 'user']
</pre>

<pre>
# spec/generators/model_generator_spec.rb

require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

# list of generators to spec are loaded
require 'generators/canable'

describe 'model_generator' do
  # include general Rails model helpers
  include RSpec::Rails::Model
  
  # include specific Rails model helpers for AR
  # also available are: MongoMapper, Mongoid and DataMapper  
  
  include RSpec::Rails::Model::ActiveRecord
  
  before :each do              
    # define generator to test
    GeneratorSpec.setup_generator 'model_generator' do
      tests Canable::Generators::ModelGenerator
    end    
    # ensure clean state before run
    remove_model 'account'    
  end

  after :each do              
    # ensure clean state after run  
    remove_model 'account'    
  end
    
  it "should not work without an existing Account model file" do            
    GeneratorSpec.with_generator do |g|   
      name = 'account'
      g.run_generator %w{account}
      g.should_not generate_file name, :model
    end
  end

  it "should decorate an existing Account model file with 'include Canable:Ables'" do            
    GeneratorSpec.with_generator do |g|  
      name = 'account'
      create_model name     
      g.run_generator %w{account}
      g.should generate_file name, :model do |content|
        content.should have_class name.camelize do |klass|
          klass.should include_module 'Canable::Ables'
        end
      end
    end
  end

  it "should decorate an Account model file with 'include Canable:Ables' and 'userstamps!'" do            
    GeneratorSpec.with_generator do |g|  
      name = 'account'
      create_model name     
      g.run_generator %w{account --userstamps}                   
      g.should generate_file name, :model do |content|
        content.should include_module 'Canable::Ables'
        content.should match /userstamps!/        
      end
    end
  end   
end
</pre>

## Note on Patches/Pull Requests
 
* Fork the project.
* Make your feature addition or bug fix.
* Add tests for it. This is important so I don't break it in a
  future version unintentionally.
* Commit, do not mess with rakefile, version, or history.
  (if you want to have your own version, that is fine but bump version in a commit by itself I can ignore when I pull)
* Send me a pull request. Bonus points for topic branches.

## Copyright

Copyright (c) 2010 Kristian Mandrup. See LICENSE for details.
