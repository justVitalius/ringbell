# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'ringbell/version'

Gem::Specification.new do |spec|
  spec.name          = "ringbell"
  spec.version       = Ringbell::VERSION
  spec.authors       = ["Vladimir Krivchenko"]
  spec.email         = ["vladimir.krivchenko@gmail.com"]
  spec.summary       = %q{A tool that can attach notifications to the ActiveRecord models for certain users.}
  spec.description   = %q{A tool that can attach notifications to the ActiveRecord models for certain users. Multiple notifications per object supported.}
  spec.homepage      = "http://github.com/prdetective/ringbell"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake", "~> 10.0"
end
