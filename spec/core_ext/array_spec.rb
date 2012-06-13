require 'spec_helper'

describe 'stricter_global_usage/core_ext/array' do
  describe '#join' do
    it 'applies the strategy when called without an argument' do
      StricterGlobalUsage::Strategy.should_receive(:apply).once.with('Array#join')
      %w(foo bar).join
    end

    it 'works like the example in the Ruby docs' do
      StricterGlobalUsage::Strategy.should_receive(:apply).exactly(0).times
      [ "a", "b", "c" ].join(nil).should == "abc"
      [ "a", "b", "c" ].join("-").should == "a-b-c"
    end
  end
end
