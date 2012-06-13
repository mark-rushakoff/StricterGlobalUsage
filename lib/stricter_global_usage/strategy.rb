module StricterGlobalUsage
  # The Strategy module represents the action to take when a function is called and its argument defaults to the value
  # of a global variable.
  #
  # Consumers of StricterGlobalUsage usually will only need to use the +use+ method to specify which strategy should be
  # applied when necessary.
  #
  # There are three built-in strategies (although consumers are free to add more through the +add+ method):
  #
  # * +raise+: The default strategy. Raises ::StricterGlobalUsage::DefaultGlobalVariableUsed exception.
  # * +warn+: Logs the call with Kernel.warn, then continues to execute the original method.
  # * +silent+: Does nothing, then continues to execute the original method.
  module Strategy
    @strategies = {}
    @name = nil

    # Apply the current strategy (warns, raises an exception, or does something else the user chose).
    # When you call apply yourself, you are expected to supply the name of the method as (e.g.) 'Dog#bark'.
    def self.apply(method)
      @strategies[@name].call(method)
    end

    # Create a new strategy. When that strategy is applied, it will be passed
    # in information about the call to Strategy.apply.
    #
    #   ::StricterGlobalUsage::Strategy.add(:my_log) do |method_name|
    #     MyLogger.log("Used #{method_name} whose argument fell back to a global variable")
    #   end
    def self.add(name, &block)
      @strategies[name] = block
    end

    # Use the strategy represented by the given name.
    #
    #   ::StricterGlobalUsage::Strategy.use(:my_log)
    def self.use(name)
      @name = name
    end

    # Use the strategy represented by the given name for the context of the given block,
    # then restore the previous strategy.
    #
    #   ::StricterGlobalUsage::Strategy.with(:silent) do
    #     ::SomeVendorLibrary.do_stuff
    #   end
    def self.with(name, &block)
      orig_name = @name
      begin
        use(name)
        yield
      ensure
        @name = orig_name
      end
    end

    add(:raise) do |method_name|
      raise ::StricterGlobalUsage::DefaultGlobalVariableUsed.new(method_name)
    end

    add(:warn) do |method_name|
      ::Kernel.warn("Called #{method_name} that used a default argument of a global variable")
    end

    add(:silent) { |_| }

    use(:raise)
  end
end
