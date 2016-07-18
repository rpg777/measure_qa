require 'bundler'
require 'bundler/gem_tasks'
begin
  Bundler.setup
rescue Bundler::BundlerError => e
  $stderr.puts e.message
  $stderr.puts 'Run `bundle install` to install missing gems'
  exit e.status_code
end

require 'rake'
require 'rake/testtask'
require 'ci/reporter/rake/minitest'

require 'pp'
require 'colored'
require 'json'

#all_tests = Dir['measures/*/tests/*_test.rb']

namespace :test do

  desc 'Run tests for all measures'
  Rake::TestTask.new('all') do |t|
    t.libs << 'test'
    t.test_files = Dir['measures/*/tests/*.rb']
    #t.warning = false
    #t.verbose = true
  end
end

task default: 'test:all'

desc 'example test'
Rake::TestTask.new('test:example') do |task|
  #SimpleCov.command_name 'test:example'
  task.test_files = FileList[
  './../measures/plug_load_controls/tests/plug_load_controls_test.rb',
  ]
end

desc 'example test 2'
Rake::TestTask.new('test:example2') do |task|
  task.pattern = 'measures/**/*_test.rb'
  #SimpleCov.command_name 'test:example2'
end

desc 'all tests'
Rake::TestTask.new('test:all_tests') do |task|
  task.test_files = all_tests
end

# require 'rake/testtask'
# desc 'Run all measure tests'
# Rake::TestTask.new('test:allofem') do |task|
#   task.libs << 'test'
#   task.test_files = FileList['measures/*/test/test_*.rb']
# end

#require 'rubocop/rake_task'
#desc 'Check the code for style consistency'
#RuboCop::RakeTask.new(:run_rubocop) do |task|
#  task.options = ['--no-color', '--out=rubocop-results.xml']
#  #task.formatters = ['RuboCop::Formatter::CheckstyleFormatter']
#  #task.requires = ['rubocop/formatter/checkstyle_formatter']
#  # don't abort rake on failure
#  task.fail_on_error = false
#end
