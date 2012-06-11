require 'spec_helper'

describe StricterGlobalUsage::Strategy do
  describe '.use' do
    it 'raises an exception with :raise' do
      ::StricterGlobalUsage::Strategy.use(:raise)
      expect { ::StricterGlobalUsage::Strategy.apply }.to raise_error(::StricterGlobalUsage::DefaultGlobalVariableUsed)
    end

    it 'warns with :warn' do
      ::StricterGlobalUsage::Strategy.use(:warn)
      Kernel.should_receive(:warn).once
      ::StricterGlobalUsage::Strategy.apply
    end
  end

  describe '.with' do
    it 'temporarily does `use` and then reverts to the old value' do
      ::StricterGlobalUsage::Strategy.use(:raise)
      ::StricterGlobalUsage::Strategy.with(:silent) do
        expect { ::StricterGlobalUsage::Strategy.apply }.not_to raise_error
      end

      expect { ::StricterGlobalUsage::Strategy.apply }.to raise_error(::StricterGlobalUsage::DefaultGlobalVariableUsed)
    end
  end
end