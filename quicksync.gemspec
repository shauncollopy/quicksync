# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'quicksync/version'

Gem::Specification.new do |gem|
  gem.name          = "quicksync"
  gem.version       = QuickSync::VERSION
  gem.authors       = ["ShaunCollopy"]
  gem.email         = ["shaun@shauncollopy.com"]
  gem.description   = %q{QuickSync gem description 1}
  gem.summary       = %q{QuickSync gem summary 2}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]
  gem.add_development_dependency "rspec", "~> 2.6"
  gem.add_development_dependency "logger", "~> 1.2.8"
end
