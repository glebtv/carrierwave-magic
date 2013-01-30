# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'carrierwave-magic/version'

Gem::Specification.new do |gem|
  gem.name          = "carrierwave-magic"
  gem.version       = CarrierWave::Magic::VERSION
  gem.authors       = ["Gleb Tv"]
  gem.email         = ["glebtv@gmail.com"]
  gem.description   = %q{ruby-filemagic and mime-types for carrierwave}
  gem.summary       = %q{Set file mime type with ruby-filemagic and extension from mime type with mime-types for carrierwave}
  gem.homepage      = "https://github.com/glebtv/carrierwave-magic"

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_runtime_dependency "ruby-filemagic"
  gem.add_runtime_dependency "carrierwave"
end
