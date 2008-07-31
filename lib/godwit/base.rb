module Godwit
  module Base

    def self.migrate
      Dir.foreach(File.join(Godwit::Config[:godwit_root], 'app', 'migrations')) do |file|
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