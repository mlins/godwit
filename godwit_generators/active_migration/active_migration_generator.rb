class ActiveMigrationGenerator < RubiGen::Base

  default_options :author => nil

  attr_reader :name, :active_model, :legacy_model

  def initialize(runtime_args, runtime_options = {})
    super
    usage if args.empty?
    @name = args.shift
    extract_options
    @active_model = args.shift
    @legacy_model = args.shift
  end

  def manifest
    record do |m|
      # Ensure appropriate folder(s) exists
      m.directory 'app/migrations/'

      # Create stubs
      m.template "active_migration.rb",  "app/migrations/#{@name}_migration.rb"
      # m.template_copy_each ["template.rb", "template2.rb"]
      # m.file     "file",         "some_file_copied"
      # m.file_copy_each ["path/to/file", "path/to/file2"]
    end
  end

  protected
    def banner
      <<-EOS
Creates an active migration

USAGE: #{$0} #{spec.name} name
EOS
    end

    def add_options!(opts)
      # opts.separator ''
      # opts.separator 'Options:'
      # For each option below, place the default
      # at the top of the file next to "default_options"
      # opts.on("-a", "--author=\"Your Name\"", String,
      #         "Some comment about this option",
      #         "Default: none") { |options[:author]| }
      # opts.on("-v", "--version", "Show the #{File.basename($0)} version number and quit.")
    end

    def extract_options
      # for each option, extract it into a local variable (and create an "attr_reader :author" at the top)
      # Templates can access these value via the attr_reader-generated methods, but not the
      # raw instance variable value.
      # @author = options[:author]
    end
end