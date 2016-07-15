require 'simplecov'
require 'coveralls'
require 'rubocop'

require 'json'
require 'fileutils'

require 'openstudio'
require 'openstudio/ruleset/ShowRunnerOutput'

puts "env is: #{::ENV.inspect}"

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

# Ignore some of the code in coverage testing
SimpleCov.start do 
  add_filter '/measures/.*/tests/'
end

#$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)

require 'minitest/autorun'
require 'minitest/reporters'
Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new # spec-like progress