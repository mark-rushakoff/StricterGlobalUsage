require 'stricter_global_usage/strategy'

class Array
  alias_method :join_without_global_check, :join
  # http://www.ruby-doc.org/core-1.9.3/Array.html#method-i-join
  # Method's argument defaults to `$,`.
  def join(*args)
    ::StricterGlobalUsage::Strategy.apply('Array#join') if args.length.zero?
    join_without_global_check(*args)
  end
end
