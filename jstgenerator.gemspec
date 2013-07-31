# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'jstgenerator/version'

Gem::Specification.new do |spec|
  spec.name          = "jstgenerator"
  spec.version       = JstGenerator::VERSION
  spec.authors       = ["Jack Franklin"]
  spec.email         = ["jack@jackfranklin.net"]
  spec.description   = "Compile javascript templates into a JST.js file"
  spec.summary       = "Automate compiling JavaScript files"
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"

  spec.add_dependency "therubyracer"
end
