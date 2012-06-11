module StricterGlobalUsage
  module Strategy
    @strategies = {}
    @name = nil
    def self.apply
      @strategies[@name].call
    end

    def self.add(name, &block)
      @strategies[name] = block
    end

    def self.use(name)
      @name = name
    end

    def self.with(name, &block)
      orig_name = @name
      begin
        use(name)
        yield
      ensure
        @name = orig_name
      end
    end

    add(:raise) do
      raise ::StricterGlobalUsage::DefaultGlobalVariableUsed
    end

    add(:warn) do
      ::Kernel.warn('')
    end

    add(:silent) { }

    use(:raise)
  end
end