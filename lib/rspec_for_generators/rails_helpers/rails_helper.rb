module RSpec  
  module Rails
    module Helper
      def create_helper name
        file =  helper_file_name(name)
        unless File.exist?(file)    
          FileUtils.mkdir_p File.dirname(file)
          File.open(file, 'w') do |f|  
            f.puts helper_content
          end
        end
      end  

      def helper_content name
        %Q{class #{name.camelize}Helper
        end}        
      end

      def remove_model name
        file = helper_file_name(name)
        FileUtils.rm_f(file) if File.exist?(file)
      end

      def remove_helpers *names
        names.each{|name| remove_helper name }
      end
      
      protected
      
      def helper_file_name name
        File.join(::Rails.root, "app/helpers/#{name}.rb")
      end        
      
    end
  end
end