require 'simplecov'
require 'coveralls'

puts "env is: #{::ENV.inspect}"

# save to CircleCI's artifacts directory if we're on CircleCI
if ENV['CIRCLE_ARTIFACTS']
  puts 'Registering coverage artifact'
  dir = File.join(ENV['CIRCLE_ARTIFACTS'], "coverage")
  SimpleCov.coverage_dir(dir)
else
  puts 'Could not find ENV[CIRCLE_ARTIFACTS]'
end

SimpleCov.formatter = Coveralls::SimpleCov::Formatter
SimpleCov.start