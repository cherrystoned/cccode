# coding: utf-8
#lib = File.expand_path('../lib', __FILE__)
#$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
$:.push File.expand_path("../lib", __FILE__)
require 'cccode/version'

Gem::Specification.new do |spec|
  spec.name          = "cccode"
  spec.version       = Cccode::VERSION
  spec.authors       = ["kirsche"]
  spec.email         = ["info@cherrystoned.com"]

  spec.summary       = 'Country and currency codes'
  spec.description   = 'Fetches and persists country and currency codes via SOAP'
  spec.homepage      = 'https://github.com/cherrystoned/cccode'
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com'"
  else
    raise "RubyGems 2.0 or newer is required to protect against " \
      "public gem pushes."
  end

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]
  
  spec.add_dependency "nori"
  spec.add_dependency "socksify"
  spec.add_dependency "httpi"
  spec.add_dependency "gyoku"
  spec.add_dependency "akami"
  spec.add_dependency "savon"

  # todo: remove before release!!!
  spec.add_dependency 'pry', '0.10.4'
  
  spec.add_development_dependency "bundler", "~> 1.13"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  #spec.add_development_dependency "rails", "~> 5.0"
  
end
