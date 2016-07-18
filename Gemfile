source 'http://rubygems.org'

# Specify your gem's dependencies in openstudio-standards.gemspec
# gemspec
gem 'rake', '~> 11.1.2'
#gem 'rake/testtask'
#gem 'ci/reporter/rake/minitest'

gem 'json', '~> 1.7.7'
# gem 'colored', '~> 1.2'

group :test do
  gem 'minitest', '~> 5.4.0'
  gem 'rubocop', '~> 0.26.0'
  gem 'rubocop-checkstyle_formatter', '~> 0.1.1'
  gem 'ci_reporter_minitest', '~> 1.0.0'
  gem 'coveralls'
  gem 'minitest-reporters'
  gem 'minitest-ci', :git => 'https://github.com/circleci/minitest-ci.git' # For CircleCI Automatic test metadata collection
end

gem 'docker-api', require: 'docker'
