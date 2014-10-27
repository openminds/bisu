# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'bisu/version'

Gem::Specification.new do |spec|
  spec.name          = 'bisu'
  spec.version       = Bisu::VERSION
  spec.authors       = ['Hannes Fostie']
  spec.email         = ['hannes.fostie@gmail.com']
  spec.summary       = %q{A security maintenance application.}
  spec.description   = %q{A security maintenance application.}
  spec.homepage      = 'https://github.com/openminds/bisu'
  spec.license       = 'MIT'

  spec.files         = Dir.glob(['lib/**/*.rb']).select { |path| File.file?(path) }
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_dependency 'oga', '~> 0.1.3'

  spec.add_development_dependency 'bundler', '~> 1.7'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'minitest', '~> 5.4.2'
end
