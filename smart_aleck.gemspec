# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'smart_aleck/version'

Gem::Specification.new do |spec|
  spec.name          = "smart_aleck"
  spec.version       = SmartAleck::VERSION
  spec.authors       = ["Dennis Walters"]
  spec.email         = ["pooster@gmail.com"]

  spec.summary       = %q{A know-it-all categorization system}
  spec.homepage      = "https://github.com/ess/smart_aleck"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.9"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.2"
  spec.add_development_dependency "faker", "~> 1.4"
  spec.add_runtime_dependency "optionally"
  spec.add_runtime_dependency "base58", "~> 0.1"
end
