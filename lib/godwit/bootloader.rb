module Godwit
  module Bootloader
  
    class << self
  
      attr_accessor :booted
  
      def boot(argv=ARGV)
        return if booted?
        load_config(argv)
        display_init unless Godwit::Config[:silence]
        load_rails
        set_load_path
        set_logger
        init_db
        init_am
        @booted = true
      end
      
      def display_init
        system('clear')
        Godwit::Buffer.puts "Godwit " + Godwit::VERSION::STRING
        Godwit::Buffer.puts "\nInitializaing..."
      end
      
      def booted?
        @booted ||= false
      end
      
      def load_rails
        unless Godwit::Config[:rails_root].nil?
          require "#{Godwit::Config[:rails_root]}/config/environment"
        end
      end
      
      def load_config(argv=ARGV)
        Godwit::Config.setup
        require File.join(Godwit::Config[:godwit_root], 'config', 'environment.rb')
        Godwit::Config.parse_args(argv)
      end
      
      def set_load_path
        $:.concat [File.join(Godwit::Config[:godwit_root], 'app', 'models'),
                   File.join(Godwit::Config[:godwit_root], 'app', 'migrations')]
        Dependencies.load_paths.concat $:           
      end
      
      def set_logger
        ActiveRecord::Base.logger = Godwit::Config[:active_record_log]
        ActiveRecord::Base.logger.level = Godwit::Config[:active_record_log_level]
        ActiveMigration::Base.logger = Godwit::Config[:active_migration_log]
        ActiveMigration::Base.logger.level = Godwit::Config[:active_migration_log_level]
      end
      
      def init_db
        db_conf = YAML::load(File.open(File.join(Godwit::Config[:godwit_root], 'config', 'database.yml')))
        LegacyRecord::Base.establish_connection(db_conf['legacy'])
        ActiveRecord::Base.establish_connection(db_conf['active']) if Godwit::Config[:rails_root].nil?
      end
      
      def init_am
        ActiveMigration::KeyMapper.storage_path = Godwit::Config[:key_mapper_path]
      end
      
    end
  
  end
end