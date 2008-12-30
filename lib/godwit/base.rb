module Godwit
  # Godwit Base class.
  #
  # When this class is initialized, the Godwit environment is booted.
  #
  class Base

    def initialize #:nodoc:
      Godwit::Bootloader.boot
    end
    
    # Starts Godwit.
    #
    def run
      Godwit::Buffer.puts "\nLoading Migrations..." unless Godwit::Config[:silence]
      unless Godwit::Config[:specific_migration]
        run_all
      else
        run_single
      end
      Godwit::Buffer.puts "\nDone." unless Godwit::Config[:silence]
    end

    protected

    def run_single #:nodoc:
      migration = Godwit::Config[:specific_migration].camelize.constantize
      migration.new.run(Godwit::Config[:skip_dependencies])
    end

    def run_all #:nodoc:
      Godwit::Config[:skip_migrations].each do |mig|
        mig.camelize.constantize.is_completed
      end
      Dir.foreach(File.join(Godwit::Config[:godwit_root], 'app', 'migrations')) do |file|
        next unless file.ends_with?('migration.rb')
        migration = file[0..-4].camelize.constantize
        unless migration.completed?
          migration.new.run(Godwit::Config[:skip_dependencies])
          migration.is_completed
        end
      end
    end

  end
end