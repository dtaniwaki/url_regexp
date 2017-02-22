# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'url_regexp/version'

Gem::Specification.new do |spec|
  spec.name          = "url_regexp"
  spec.version       = UrlRegexp::VERSION
  spec.authors       = ["dtaniwaki"]
  spec.email         = ["daisuketaniwaki@gmail.com"]
  spec.license       = "MIT"

  spec.summary       = %q{Generate regular expression for URL}
  spec.description   = %q{Generate regular expression for URL}
  spec.homepage      = "https://github.com/dtaniwaki/url_regexp"

  spec.files = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  spec.executables   = `git ls-files -- bin/*`.split("\n").map { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.required_ruby_version = [">= 2.1.0", "< 2.5"]

  spec.add_development_dependency "rake", ">= 10.0", "< 13"
  spec.add_development_dependency "rspec", ">= 3.0", "< 4"
  spec.add_development_dependency "simplecov", "~> 0.12"
  spec.add_development_dependency "timecop", "~> 0.8"
  spec.add_development_dependency "rubocop", "~> 0.47"
  spec.add_development_dependency "rubocop-rspec", "~> 1.4"
  spec.add_development_dependency "coveralls", "~> 0.8"
end
