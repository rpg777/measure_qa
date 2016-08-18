require 'bundler'
Bundler.setup

require 'rake'
require 'rake/testtask'
require 'ci/reporter/rake/minitest'

require 'pp'
# require 'colored'
require 'json'

namespace :test do

  desc 'Run tests for all measures'
  Rake::TestTask.new('all') do |t|
    t.libs << 'test'
    t.test_files = Dir['measures/**/tests/*_test.rb']
    t.warning = false
    t.verbose = true
  end
end

task default: 'test:all'

require 'rubocop/rake_task'
desc 'Check the code for style consistency'
RuboCop::RakeTask.new(:run_rubocop) do |task|
  style_files = ["measures/**/measure.rb", "measures/**/*.rb"]
  task.options = ['--out=test/style/rubocop-results.xml']
  task.formatters = ['RuboCop::Formatter::CheckstyleFormatter']
  task.requires = ['rubocop/formatter/checkstyle_formatter']
  task.fail_on_error = false # don't abort rake on failure
end
