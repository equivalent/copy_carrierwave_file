# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'copy_carrierwave_file/version'

Gem::Specification.new do |spec|
  spec.name          = "copy_carrierwave_file"
  spec.version       = CopyCarrierwaveFile::VERSION
  spec.authors       = ["Tomas Valent"]
  spec.email         = ["equivalent@eq8.eu"]
  spec.description   = %q{Gems main responsibility is to provide service for copying Carrierwave files between records }
  spec.summary       = %q{Copy Carrierwave files between records}
  spec.homepage      = "http://eq8.eu"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "carrierwave", "~> 0.9"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "activerecord", "~> 3.2"
  spec.add_development_dependency "minitest", "~> 5"
  spec.add_development_dependency "mocha", "~> 0.14"
  spec.add_development_dependency "sqlite3"
  spec.add_development_dependency "fog"
  spec.add_development_dependency "pry"
  spec.add_development_dependency 'coveralls'
end
