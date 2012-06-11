require 'stricter_global_usage/strategy'

class Array
  alias_method :join_without_global_check, :join
  def join(*args)
    ::StricterGlobalUsage::Strategy.apply if args.length.zero?
    join_without_global_check(*args)
  end
end
