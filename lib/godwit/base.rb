module Godwit
  class Base
  
    class << self
    
      def run
        Dir.foreach(File.join(GODWIT_ROOT, 'app', 'migrations')) do |file|
          next unless file.ends_with?('migration.rb')
          migration = file[0..-4].camelize.constantize
          unless migration.completed?
            puts "Running #{file[0..-4]}..."
            migration.new.run
            migration.is_completed
          end 
          puts "#{file} is completed"
        end
      end
      
    
    end
  
  end
end

module ActiveMigration
  class Base
  
    def handle_error(model, reference_field, error_field, error_message)
      puts "********************************************************************"
      begin
        puts "Failed on " + model.instance_eval(reference_field).to_s + " because '" + error_field.to_s + "' " + error_message.to_s
      rescue
        puts "Failed on associated model: #{model.class.to_s} because #{error_field.to_s} #{error_message.to_s}"
      end
      puts "The current value of '#{error_field.to_s}' is: '" + model.instance_eval(error_field).to_s + "'"
      print "Please enter a new value for '#{error_field}': "
      new_value = gets
      puts "********************************************************************"
      new_value.chomp
    end
    
    def handle_success(model, reference_field)
      puts "Successfully migrated " + model.instance_eval(reference_field)
    end
    
    end
  end