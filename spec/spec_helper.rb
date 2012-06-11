require 'rspec'
require 'stricter_global_usage'

include StricterGlobalUsage

RSpec.configure do |config|
  config.before do
    ::StricterGlobalUsage::Strategy.use(:raise)
  end
end