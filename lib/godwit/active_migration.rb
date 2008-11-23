module ActiveMigration
  class Base
    
    def initialize
      @error = false 
      @count = 0
      @backspaces = -1
      @percentage = 0
      @printed_class = false
    end 
    
    def handle_error()
      if Godwit::Config[:silence] || !Godwit::Config[:debug]
        puts "\n\n\n"
        raise ActiveMigrationError, 'Failed to save the active record. You should check the logs or run migrate with the -D option to debug.' 
      end
      unless @error || @skip
        debugger
        @error = true
      else
        no_resolve
        @error = false
        handle_error
      end
    end

    def handle_success()
      return if Godwit::Config[:silence]
      unless @error    
        success
      else
        resolve
        success
        @error = false
      end
    end
    
    def resolve
      system('clear')
      puts "The error has been resolved."
      puts "\nGodwit will continue the migration in 5 seconds..."
      sleep(5)
      system('clear')
      print Godwit::Buffer.buffer
    end
    
    def no_resolve
      system('clear')
      puts "You have not resolved the error!"
      puts "Please make sure you check that @active_record.valid? is true before you type 'exit'."
      puts "\nYou will return to the debug console in 5 seconds..."
      sleep(5)
    end
    
    def debugger
      system('clear')
      puts "Godwit " + Godwit::VERSION::STRING
      puts "\nCurrent Migration: " + self.class.to_s
      puts "\nYou encountered an invalid record while trying to save.  You can attempt to reconcile this in the debug console."
      puts "When you are done type 'exit' and godwit will try to save the record again.  Do not try to save the record with #save yourself!"
      puts "Use methods like #valid? and #errors to determine the problem."
      puts "\nYou have the following instance variables available to manipulate:"
      puts "\n@active_record\t\tThis is the record that failed to save.  You should fix this record."
      puts "@legacy_record\t\tThis should only be used for information.  It is unwise to manipulate this object."
      puts "@mapping\t\tThis should only be used for information.  It is unwise to manipulate this object."
      puts "\nLoading Debug Console..."
      puts "\n"
      IRB.start_session(binding)
    end
    
    def success
      if @active_record.is_a?(Array)
        if @active_array
          if @active_array != @active_record.object_id
            @count += 1
            @active_array = @active_record.object_id
          end
        else
          @count += 1
          @active_array = @active_record.object_id
        end
      else
        @count += 1
      end
      percent = ((@count.to_f / @num_of_records.to_f) * 100).to_i.to_s
      return if (@percentage == percent) && @count > 1
      @percentage = percent
      if @count == 1 && !@printed_class
        Godwit::Buffer.print("\n" + self.class.to_s + "\t\t\t")
        @printed_class = true
      end 
      Godwit::Buffer.print(("\b" * (@backspaces + 1)) + @percentage + '%')
      @backspaces = @percentage.length
    end
    
  end
end