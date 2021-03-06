module Godwit
  module Bootloader
  
    class << self
  
      attr_accessor :booted
  
      def boot(argv=ARGV) #:nodoc:
        return if booted?
        load_config(argv)
        display_init unless Godwit::Config[:silence]
        load_rails
        set_load_path
        set_logger
        init_db
        init_am
        load_plugins
        @booted = true
      end
      
      def display_init #:nodoc:
        system('clear')
        Godwit::Buffer.puts "Godwit " + Godwit::VERSION::STRING
        Godwit::Buffer.puts "\nInitializaing..."
      end
      
      def booted? #:nodoc:
        @booted ||= false
      end
      
      def load_rails #:nodoc:
        unless Godwit::Config[:rails_root].nil?
          require "#{Godwit::Config[:rails_root]}/config/environment"
        end
      end
      
      def load_config(argv=ARGV) #:nodoc:
        Godwit::Config.setup
        require File.join(Godwit::Config[:godwit_root], 'config', 'environment.rb')
        Godwit::Config.parse_args(argv)
      end
      
      def set_load_path #:nodoc:
        $:.concat [File.join(Godwit::Config[:godwit_root], 'app', 'models'),
                   File.join(Godwit::Config[:godwit_root], 'app', 'migrations'),
                   File.join(Godwit::Config[:godwit_root], 'lib')]
        Dir[File.join(Godwit::Config[:godwit_root], 'vendor', 'plugins', '*', 'lib')].each do |dir|
          $:.push dir
        end
        ActiveSupport::Dependencies.load_paths.concat $:           
      end
      
      def set_logger #:nodoc:
        ActiveRecord::Base.logger = Godwit::Config[:active_record_log]
        ActiveRecord::Base.logger.level = Godwit::Config[:active_record_log_level]
        ActiveMigration::Base.logger = Godwit::Config[:active_migration_log]
        ActiveMigration::Base.logger.level = Godwit::Config[:active_migration_log_level]
      end
      
      def init_db #:nodoc:
        db_conf = YAML::load(File.open(File.join(Godwit::Config[:godwit_root], 'config', 'database.yml')))
        LegacyRecord::Base.establish_connection(db_conf['legacy'])
        ActiveRecord::Base.establish_connection(db_conf['active']) if Godwit::Config[:rails_root].nil?
      end
      
      def init_am #:nodoc:
        ActiveMigration::KeyMapper.storage_path = Godwit::Config[:key_mapper_path]
      end
      
      def load_plugins #:nodoc:
        Dir[File.join(Godwit::Config[:godwit_root], 'vendor', 'plugins', '*', 'init.rb')].each do |init|
          require init
        end
      end
      
    end
  
  end
end