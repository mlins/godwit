require 'optparse'

module Godwit
  class Config
    
    class << self
    
      attr_accessor :configuration
      
      # Default configuration details.
      def defaults
        @defaults ||= {
          :godwit_root       => Dir.pwd,
          :rails_root        => nil,
          :key_mapper_path   => File.join(Dir.pwd, 'tmp'),
          :skip_dependencies => false,
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
        @configuration ||= {}
        if @configuration == {}
          @configuration = defaults.merge(settings)
        else
          @configuration.merge!(settings)
        end
      end
      
      # Parses command line arguments and stores them in the config.
      #
      def parse_args(argv = ARGV)
        options = {}
        opts = OptionParser.new do |opts|

          opts.program_name = "Godwit"
          opts.version = Godwit::VERSION::STRING
          opts.banner  = "Usage: migrate [options] [my_migration]\n"
          opts.banner += "   or: migrate\n"
          opts.separator ""

          opts.on("-s", "--skip-dependencies", "Skip Dependencies") do |n|
            options[:skip_dependencies] = true
          end

          opts.on_tail("-h", "--help", "Show this message") do
            puts opts
            exit
          end

          opts.on_tail("-v", "--version", "Show version") do
            puts Godwit::Version::STRING
            exit
          end

        end
        opts.parse!(argv)
        Godwit::Config.setup(options)
      end
      
    end
    
  end
end