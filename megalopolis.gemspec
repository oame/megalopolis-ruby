# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'megalopolis/version'

Gem::Specification.new do |gem|
  gem.name          = "megalopolis"
  gem.version       = Megalopolis::VERSION
  gem.authors       = ["o_ame"]
  gem.email         = ["oame@oameya.com"]
  gem.description   = %q{Megalopolis API wrapper for Ruby}
  gem.summary       = %q{Megalopolis API wrapper for Ruby}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]
  gem.add_dependency "json" if RUBY_VERSION < "1.9.0"
end
