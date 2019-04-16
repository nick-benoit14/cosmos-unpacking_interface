
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "cosmos/unpacking_interface/version"

Gem::Specification.new do |spec|
  spec.name          = "cosmos-unpacking_interface"
  spec.version       = UnpackingInterface::VERSION
  spec.authors       = ["Center for Space Engineering", "Nick Benoit"]
  spec.email         = ["cse@engineering.usu.edu", "nick.benoit14@gmail.com"]

  spec.summary       = %q{
    A custom interface that unpacks aggregate packets (packets with many granules) into many 
    simple packets (packets with a single granule). This way we can use all the cosmos niceties 
    without having to send packets for individual measurements. Essentially we unpack an aggregate 
    packet into many packets that are stored in a queue that is read from. When the queue is empty 
    we look for new aggregate packets
  }
  spec.homepage      = "https://github.com/nick-benoit14/cosmos-unpacking_interface"
  spec.license       = "MIT"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end

  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake", "~> 10.0"

  spec.add_runtime_dependency "cosmos", "4.3"
end
