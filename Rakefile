require 'bundler'
Bundler.setup

require 'rake'
require 'rake/testtask'
require 'ci/reporter/rake/minitest'

require 'pp'
# require 'colored'
require 'json'

require 'bcl'
require 'bcl/version'

gem 'test-unit'

namespace :test do

  desc 'Run tests for all measures'
  Rake::TestTask.new('all') do |t|
    t.libs << 'test'
    t.pattern = "measures/parsed/**/tests/*_[tT]est.rb"
    #t.test_files = Dir['measures/parsed/AddCostPerAreaToUnusedConstruction/tests/*_[tT]est.rb'] # run a one-off test

    t.warning = false
    t.verbose = true

  end

  desc "Run all test suites with error handling"
  task "all_subproc" do
    %W[test:all].each do |task_name|
      sh "rake #{task_name}" do
  # Ignore errors
      end
    end
    puts "Finished running all tests"
  end

  task :simple do
    Dir.glob('./measures/parsed/**/tests/*_[tT]est.rb').each { |file| require file}
  end

end

require 'rubocop/rake_task'
desc 'Check the code for style consistency'
RuboCop::RakeTask.new(:run_rubocop) do |task|
  style_files = ["measures/**/measure.rb", "measures/**/*.rb"]
  task.options = ['--out=test/style/rubocop-results.xml']
  task.formatters = ['RuboCop::Formatter::CheckstyleFormatter']
  task.requires = ['rubocop/formatter/checkstyle_formatter']
  task.fail_on_error = false # don't abort rake on failure

end

desc 'retrieve measures, parse, and create json metadata file' # get all the measures
task :measure_metadata do
  bcl = BCL::ComponentMethods.new
  bcl.login   # do this to set BCL URL
  # only retrieve "NREL" measures
  bcl.measure_metadata('NREL')

end

task default: 'test:all'