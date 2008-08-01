module Godwit
  module Base

    def self.migrate
      unless Godwit::Config[:specific_migration]
        self.run_all
      else
        self.run_single 
      end
    end
    
    def self.run_single
      migration = Godwit::Config[:specific_migration].camelize.constantize
      migration.new.run(Godwit::Config[:skip_dependencies])
    end
    
    def self.run_all
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