# -*- encoding: utf-8 -*-

require File.expand_path('../lib/stricter_global_usage/version', __FILE__)

Gem::Specification.new do |gem|
  gem.name          = "stricter_global_usage"
  gem.version       = StricterGlobalUsage::VERSION
  gem.summary       = %q{Raises exceptions or runtime warnings when calling methods whose arguments default to global variables.}
  gem.description   = %q{TODO: Description}
  gem.license       = "MIT"
  gem.authors       = ["Mark Rushakoff"]
  gem.email         = "mark.rushakoff@gmail.com"
  gem.homepage      = "https://github.com/mark-rushakoff/stricter_global_usage#readme"

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_development_dependency "bundler", "~> 1.0"
end
