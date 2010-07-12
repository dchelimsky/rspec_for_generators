module RSpec  
  module Rails
    module View
      def create_view name, content
        file = view_file_name(name)
        unless File.exist?(file)    
          FileUtils.mkdir_p File.dirname(file)
          File.open(file, 'w') do |f|  
            f.puts content
          end
        end
      end  

      def remove_view name
        file = view_file_name(name)
        FileUtils.rm_f(file) if File.exist?(file)
      end

      def remove_views *names
        names.each{|name| remove_view name }
      end      
      
      def view_file_name name
        File.join(::Rails.root, "app/views/#{name}.rb")
      end        
      
    end
  end
end