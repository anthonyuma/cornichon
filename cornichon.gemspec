# coding: utf-8
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "cornichon/version"

Gem::Specification.new do |spec|
  spec.name          = "cornichon"
  spec.version       = Cornichon::VERSION
  spec.authors       = ["thomgray"]
  spec.email         = ["thomdikdave@hotmail.com"]
  spec.executables   << 'cornichon'

  spec.summary       = %q{A fancy gherkin}
  spec.description   = %q{A gherkin transpiler that allows you to write cucumber (gherkin) features programatically, thereby greatly improving your test coverage!}
  spec.homepage      = "https://github.com/thomgray/cornichon"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end

  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.15"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "cucumber"
end
