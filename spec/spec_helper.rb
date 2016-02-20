require 'rubygems'
require 'rspec'
require 'simplecov'
require 'coveralls'
Coveralls.wear!

resultset_path = SimpleCov::ResultMerger.resultset_path
FileUtils.rm resultset_path if File.exist? resultset_path
SimpleCov.use_merging true
SimpleCov.at_exit do
  SimpleCov.command_name "fork-#{$PID}"
  SimpleCov.result.format!
end
SimpleCov.formatter = SimpleCov::Formatter::MultiFormatter[
  SimpleCov::Formatter::HTMLFormatter,
  Coveralls::SimpleCov::Formatter
]
SimpleCov.start do
  add_filter 'spec/'
end

require 'url_regexp'

Dir[File.join(File.dirname(__FILE__), 'support/**/*.rb')].each { |f| require f }

RSpec.configure do |config|
end
