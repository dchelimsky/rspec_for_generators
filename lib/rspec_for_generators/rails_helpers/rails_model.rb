module RSpec  
  module Rails
    module Model
      module ActiveRecord
        def file_content name
          %Q{class #{name.camelize} < ActiveRecord::Base
          end}
        end
      end

      module MongoMapper
        def file_content name
          %Q{class #{name.camelize}
            include MongoMapper::Document
          end}
        end
        
        def field name, type = nil
          return "key :#{name}, #{type}" if type
          "key :#{name}"
        end
      end

      module Mongoid
        def file_content name
          %Q{class #{name.camelize}
            include Mongoid::Document
          end}
        end
        
        def field name, type = nil
          return "field :#{name}, :type => #{type}" if type
          "field :#{name}"
        end        
      end

      module DataMapper
        def file_content name
          %Q{class #{name.camelize}
            include DataMapper::Resource
          end}
        end
        
        def field name, type = nil
          return "property :#{name}, #{type}" if type
          "property :#{name}"
        end        
      end

      def self.set_orm orm
        orm_module = case orm
        when :active_record
          ActiveRecord
        when :data_mapper
          DataMapper
        when :mongo_mapper
          MongoMapper
        when :mongoid
          Mongoid
        end
        self.extend(orm_module)
      end
      
      def create_model name, &block
        file =  model_file_name(name)
        unless File.exist?(file)    
          FileUtils.mkdir_p File.dirname(file)
          File.open(file, 'w') do |f|  
            f.puts file_content(name)
            yield f if block_given?
          end
        end
      end  

      def remove_model name
        file = model_file_name(name)
        FileUtils.rm_f(file) if File.exist?(file)
      end

      def remove_models *names
        names.each{|name| remove_model name }
      end      
      
      def model_file_name name
        File.join(::Rails.root, "app/models/#{name}.rb")
      end        
    end
  end
end