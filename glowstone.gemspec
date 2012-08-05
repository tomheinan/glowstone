# -*- encoding: utf-8 -*-
require File.expand_path('../lib/glowstone/version', __FILE__)

Gem::Specification.new do |gem|
	gem.name          = "glowstone"
	gem.authors       = ["Tom Heinan"]
	gem.email         = ["me@tomheinan.com"]
	gem.description   = "Glowstone helps shed light on your Minecraft server!"
	gem.summary       = "This tiny gem implements the Gamespy query protocol to access pertinent real-time information hidden away inside your Minecraft server."
	gem.homepage      = "https://github.com/tomheinan/glowstone"

	gem.files         = `git ls-files`.split($\)
	gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
	gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
	gem.require_paths = ["lib"]
	gem.version       = Glowstone::VERSION

	gem.add_dependency "bindata", "~> 1.4.5"
end
