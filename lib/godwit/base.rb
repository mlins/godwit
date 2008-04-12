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