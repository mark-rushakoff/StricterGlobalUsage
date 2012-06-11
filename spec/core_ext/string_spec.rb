require 'spec_helper'

describe 'stricter_global_usage/core_ext/string' do
  describe '#split' do
    it 'applies the strategy when called without an argument' do
      StricterGlobalUsage::Strategy.should_receive(:apply).once
      '1,2,3,4,5'.split
    end

    it 'works like the example in the Ruby docs' do
      StricterGlobalUsage::Strategy.should_receive(:apply).exactly(0).times
      " now's  the time".split(nil).should == ["now's", "the", "time"]
      " now's  the time".split(' ').should == ["now's", "the", "time"]
      "1, 2.34,56, 7".split(%r{,\s*}).should == ["1", "2.34", "56", "7"]
      "hello".split(%r//).should == ["h", "e", "l", "l", "o"]
      "hello".split(%r//, 3).should == ["h", "e", "llo"]
      "hi mom".split(%r{\s*}).should == ["h", "i", "m", "o", "m"]

      "mellow yellow".split("ello").should == ["m", "w y", "w"]
      "1,2,,3,4,,".split(',').should == ["1", "2", "", "3", "4"]
      "1,2,,3,4,,".split(',', 4).should == ["1", "2", "", "3,4,,"]
      "1,2,,3,4,,".split(',', -4).should == ["1", "2", "", "3", "4", "", ""]
    end
  end
end
