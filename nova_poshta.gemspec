# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'nova_poshta/version'

Gem::Specification.new do |spec|
  spec.name = "nova_poshta"
  spec.version = NovaPoshta::VERSION
  spec.authors = ["Igor Gonchar"]
  spec.email = ["igor.gonchar@gmail.com"]

  spec.summary = %q{Ruby-client to novaposhta.ua API.}
  spec.homepage = "https://github.com/gigorok/nova_poshta"
  spec.license = "MIT"

  spec.files = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "activesupport"
  spec.add_development_dependency "bundler", "~> 1.12"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "webmock"
end
