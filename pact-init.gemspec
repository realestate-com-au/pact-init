# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'pact/init/version'

Gem::Specification.new do |spec|
  spec.name          = "pact-init"
  spec.version       = Pact::Init::VERSION
  spec.authors       = ["Joe Sustaric",'Princy James']
  spec.email         = ["jsustari@thoughtworks.com",'princy.james@rea-group.com']
  spec.summary       = %q{This gem will help initialize skeleton code tests for both consumer project and provider projects}
  spec.description   = %q{pact-init-consumer pact-init-provider}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency 'thor'
  
  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency 'rspec'
  spec.add_development_dependency 'byebug'

end
