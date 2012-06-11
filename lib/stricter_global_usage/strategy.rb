module StricterGlobalUsage
  module Strategy
    def self.apply
      raise ::StricterGlobalUsage::DefaultGlobalVariableUsed
    end
  end
end