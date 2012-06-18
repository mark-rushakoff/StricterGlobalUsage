require 'stricter_global_usage/strategy'

class String
  alias_method :split_without_global_check, :split
  
  # http://ruby-doc.org/core-1.9.3/String.html#method-i-split
  # Method's argument defaults to `$;`.
  def split(*args)
    ::StricterGlobalUsage::Strategy.apply('String#split') if args.length.zero?
    split_without_global_check(*args)
  end
end
