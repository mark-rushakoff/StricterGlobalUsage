require 'stricter_global_usage/default_global_variable_used'

class String
  alias_method :split_without_global_check, :split
  def split(*args)
    ::StricterGlobalUsage::Strategy.apply if args.length.zero?
    split_without_global_check(*args)
  end
end