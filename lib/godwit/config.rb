require 'optparse'

module Godwit
  class Config
    
    class << self
    
      attr_accessor :configuration
      
      # Default configuration details.
      def defaults
        @defaults ||= {
          :godwit_root                => Dir.pwd,
          :active_record_log          => nil,
          :active_record_log_level    => nil,
          :active_migration_log       => nil,
          :active_migration_log_level => nil,
          :rails_root                 => nil,
          :key_mapper_path            => File.join(Dir.pwd, 'data', 'keymaps'),
          :skip_dependencies          => false,
          :skip_migrations            => [],
          :specific_migration         => nil,
          :silence                    => false,
          :debug                      => false
        }
      end
      
      # Yields the configuration.
      #
      #   Godwit::Config.use do |config|
      #     config[:keymapper_path] = 'some/other/path'
      #   end
      #
      def use
        @configuration ||= {}
        yield @configuration
      end
      
      # Returns the config value at the specified key.
      #
      def [](key)
        (@configuration||={})[key]
      end
      
      # Set the config value at the specified key.
      #
      def []=(key,val)
        @configuration[key] = val
      end
      
      # Deletes the config element by key.
      #
      def delete(key)
        @configuration.delete(key)
      end
      
      # Sets up the configuration by storing the given settings.
      #
      def setup(settings = {})
        @configuration = defaults.merge(settings)
      end
      
      # Parses command line arguments and stores them in the config.
      #
      def parse_args(argv = ARGV)
        options = {}
        opts = OptionParser.new do |opts|

          opts.program_name = "Godwit"
          opts.version = Godwit::VERSION::STRING
          opts.banner  = "Usage: migrate [OPTIONS]\n"
          opts.separator ""

          opts.on("-D", "--debug", "Debug mode.") do |n|
            options[:debug] = true
          end

          opts.on("-s", "--silent", "Silence, no output, good for scripts. Silence overrides Debug(you can't debug silently)") do |n|
            options[:silence] = true
          end

          opts.on("-m", "--skip-migrations X,Y,Z", Array, "Use underscores. Won't skip it if it's a dependency, make sure you use -d too if you need that.") do |migrations|
            options[:skip_migrations] = migrations
          end

          opts.on("-d", "--skip-dependencies", "Skip Dependencies") do |n|
            options[:skip_dependencies] = true
          end
          
          opts.on("-S", "--specific-migration MIGRATION", "Specific Migration. Use underscores. Ex. products_migration.") do |migration|
            options[:specific_migration] = migration
          end

          opts.on_tail("-h", "--help", "Show this message") do
            puts opts
            exit
          end

          opts.on_tail("-v", "--version", "Show version") do
            puts 'Godwit ' + Godwit::VERSION::STRING
            exit
          end

        end
        opts.parse!(argv)
        Godwit::Config.setup(options)
      end
      
    end
    
  end
end