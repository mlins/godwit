module Godwit
  module Callbacks

    CALLBACKS = %w(before_run after_run)

    def self.included(base)
      base.send :alias_method_chain, :run, :callbacks
      base.send :include, ActiveSupport::Callbacks
      base.define_callbacks *CALLBACKS
    end

    # This is called before you anything actually starts.
    #
    def before_run() end
    # This is called after everything else finishes.
    #
    def after_run() end
    def run_with_callbacks #:nodoc:
      callback(:before_run)
      run_without_callbacks
      callback(:after_run)
    end

    private

    def callback(method) #:nodoc:
      run_callbacks(method)
      send(method)
    end

  end
end