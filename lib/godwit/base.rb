module Godwit
  class Base
    
    def initialize
      Godwit::Bootloader.boot
    end

    def run
      Godwit::Buffer.puts "\nLoading Migrations..." unless Godwit::Config[:silence]
      unless Godwit::Config[:specific_migration]
        run_all
      else
        run_single 
      end
      Godwit::Buffer.puts "\nDone." unless Godwit::Config[:silence]
    end
    
    def run_single
      migration = Godwit::Config[:specific_migration].camelize.constantize
      migration.new.run(Godwit::Config[:skip_dependencies])
    end
    
    def run_all
      Dir.foreach(File.join(Godwit::Config[:godwit_root], 'app', 'migrations')) do |file|
        next unless file.ends_with?('migration.rb')
        migration = file[0..-4].camelize.constantize
        unless migration.completed? || Godwit::Config[:skip_migrations].include?(migration.to_s.underscore)
          migration.new.run(Godwit::Config[:skip_dependencies])
          migration.is_completed
        end
      end
    end
    
  end
end