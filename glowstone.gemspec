# -*- encoding: utf-8 -*-
require File.expand_path('../lib/glowstone/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Tom Heinan"]
  gem.email         = ["me@tomheinan.com"]
  gem.description   = "Glowstone helps shed light on your Minecraft server!"
  gem.summary       = "This tiny gem implements the Gamespy query protocol to access server information built in to all Minecraft servers version 1.8+."
  gem.homepage      = "http://tomheinan.com"

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "glowstone"
  gem.require_paths = ["lib"]
  gem.version       = Glowstone::VERSION
end
