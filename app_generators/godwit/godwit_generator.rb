class GodwitGenerator < RubiGen::Base
  
  DEFAULT_SHEBANG = File.join(Config::CONFIG['bindir'],
                              Config::CONFIG['ruby_install_name'])
  
  default_options :author => nil
  
  attr_reader :name
  
  def initialize(runtime_args, runtime_options = {})
    super
    usage if args.empty?
    @destination_root = File.expand_path(args.shift)
    @name = base_name
    extract_options
  end

  def manifest
    record do |m|
      # Ensure appropriate folder(s) exists
      m.directory ''
      BASEDIRS.each { |path| m.directory path }

      script_options     = { :chmod => 0755, :shebang => options[:shebang] == DEFAULT_SHEBANG ? nil : options[:shebang] }

      # Create stubs
      # m.template "template.rb",  "some_file_after_erb.rb"
      # m.file     "file",         "some_file_copied"
      
      # Config
      %w(boot.rb database.yml environment.rb initializer.rb).each do |file|
        m.file "config/#{file}", "config/#{file}"
      end
      
      # Scripts
      %w(console migrate).each do |file|
        m.file "script/#{file}", "script/#{file}", script_options
      end
      
      # Blank Log
      m.file "log/migration.log", "log/migration.log"
      
      m.dependency "install_rubigen_scripts", [destination_root, 'godwit'], 
        :shebang => options[:shebang], :collision => :force
    end
  end

  protected
    def banner
      <<-EOS
USAGE:

godwit [application_name]
EOS
    end

    def add_options!(opts)
      opts.separator ''
      opts.separator 'Options:'
      # For each option below, place the default
      # at the top of the file next to "default_options"
      # opts.on("-a", "--author=\"Your Name\"", String,
      #         "Some comment about this option",
      #         "Default: none") { |options[:author]| }
      opts.on("-v", "--version", "Show the #{File.basename($0)} version number and quit.")
    end
    
    def extract_options
      # for each option, extract it into a local variable (and create an "attr_reader :author" at the top)
      # Templates can access these value via the attr_reader-generated methods, but not the
      # raw instance variable value.
      # @author = options[:author]
    end

    # Installation skeleton.  Intermediate directories are automatically
    # created so don't sweat their absence here.
    BASEDIRS = %w(
      log
      script
      tmp
      config
      app/models/legacy
      app/migrations
    )
end