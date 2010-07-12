module RSpec  
  module Rails
    module Mailer
      def create_mailer name, content
        file = mailer_file_name(name)
        unless File.exist?(file)    
          FileUtils.mkdir_p File.dirname(file)
          File.open(file, 'w') do |f|  
            f.puts content
          end
        end
      end  

      def remove_mailer name
        file = mailer_file_name(name)
        FileUtils.rm_f(file) if File.exist?(file)
      end

      def remove_mailers *names
        names.each{|name| remove_mailer name }
      end      
      
      def mailer_file_name name
        File.join(::Rails.root, "app/mailers/#{name}.rb")
      end        
      
    end
  end
end