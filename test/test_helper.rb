require 'simplecov'
SimpleCov.start

require 'minitest/autorun'
require 'minitest/reporters'

require 'json'
require 'fileutils'

require 'openstudio'
require 'openstudio/ruleset/ShowRunnerOutput'


require 'coveralls'

# Ignore some of the code in coverage testing
=begin
SimpleCov.start do
  add_filter '/.idea/'
  add_filter '/.yardoc/'
  add_filter '/data/'
  add_filter '/doc/'
  add_filter '/docs/'
  add_filter '/pkg/'
  add_filter '/test/'
  add_filter '/hvac_sizing/'
  add_filter 'version'  
end
=end
# $LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)

Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new # spec-like progress

#puts "env is: #{::ENV.inspect}"

# Get the code coverage in html for local viewing
# and in JSON for coveralls
#SimpleCov.formatter = Coveralls::SimpleCov::Formatter
SimpleCov.formatter = SimpleCov::Formatter::MultiFormatter[
  SimpleCov::Formatter::HTMLFormatter,
  Coveralls::SimpleCov::Formatter
]

# save to CircleCI's artifacts directory if we're on CircleCI
if ENV['CIRCLE_ARTIFACTS']
  puts 'Registering coverage artifact'
  dir = File.join(ENV['CIRCLE_ARTIFACTS'], "coverage")
  SimpleCov.coverage_dir(dir)
else
  puts '$CIRCLE_ARTIFACTS not set, running locally?'
end