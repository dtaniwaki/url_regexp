# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'url_regexp/version'

Gem::Specification.new do |spec|
  spec.name          = "url_regexp"
  spec.version       = UrlRegexp::VERSION
  spec.authors       = ["Daisuke Taniwaki"]
  spec.email         = ["daisuketaniwaki@gmail.com"]
  spec.license     = "MIT"

  spec.summary       = %q{Generate regular expression for URL}
  spec.description   = %q{Generate regular expression for URL}
  spec.homepage      = "https://github.com/dtaniwaki/url_regexp"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.require_paths = ["lib"]

  spec.required_ruby_version = [">= 2.1.0", "< 2.5"]

  spec.add_development_dependency "bundler", "~> 1.11"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
end
