require 'spec_helper'
require 'stricter_global_usage'

describe StricterGlobalUsage do
  it "should have a VERSION constant" do
    subject.const_get('VERSION').should_not be_empty
  end
end
