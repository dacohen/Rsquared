# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'Rsquared/version'

Gem::Specification.new do |spec|
  spec.name          = "Rsquared"
  spec.version       = Rsquared::VERSION
  spec.authors       = ["Daniel Cohen"]
  spec.email         = ["dcohen@gatech.edu"]
  spec.description   = %q{A full-featured Ruby statistics library with assumption verification}
  spec.summary       = %q{Provides statistical distributions, tests and verifies relevant assumptions}
  spec.homepage      = "https://github.com/dacohen/Rsquared"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "distribution"
end
