# Set the root path
GODWIT_ROOT = File.join(File.dirname(__FILE__), '..') unless defined?(GODWIT_ROOT)

module Godwit

    def self.boot!
      require 'rubygems'
      require 'active_support'
      require 'active_record'
      require 'active_migration'
      require 'godwit'

      # Load the initializer.
      require File.join(File.dirname(__FILE__), 'initializer')

      # Load the environment
      require File.join(File.dirname(__FILE__), 'environment')

      # This is usually just a dep warning, but we want it to fail.
      Object.send :undef_method, :id

      # Load paths for Godwit.
      $:.concat [File.join(GODWIT_ROOT, 'app', 'models'),
                 File.join(GODWIT_ROOT, 'app', 'migrations')]
      
      # Load an existing Rails Application.
      if defined?(RAILS_ROOT)
        require "#{RAILS_ROOT}/config/environment"
      end

      # Let ActiveSupport know about our load path.
      Dependencies.load_paths.concat $:

      # Start the logger.
      ActiveRecord::Base.logger = Logger.new(File.open(File.join(GODWIT_ROOT, 'log', 'migration.log'), File::WRONLY | File::APPEND))

      # Establish connection to databases.
      db_conf = YAML::load(File.open(File.join(File.dirname(__FILE__), 'database.yml')))
      LegacyRecord::Base.establish_connection(db_conf['legacy'])
      ActiveRecord::Base.establish_connection(db_conf['active']) unless defined? RAILS_ROOT
    end
    
end

Godwit.boot!