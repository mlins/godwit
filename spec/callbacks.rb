module Godwit
  module Callbacks
    
    CALLBACKS = %w(before_migrate after_migrate)

    def self.included(base)
      base.send :alias_method_chain, :migrate, :callbacks
      base.send :include, ActiveSupport::Callbacks
      base.define_callbacks *CALLBACKS
    end

    # This is called before you anything actually starts.
    #
    def before_migrate() end
    # This is called after everything else finishes.
    #
    def after_migrate() end
    def migrate_with_callbacks #:nodoc:
      callback(:before_migrate)
      migrate_without_callbacks
      callback(:after_migrate)
    end
    
    private

    def callback(method) #:nodoc:
      run_callbacks(method)
      send(method)
    end
    
  end
end