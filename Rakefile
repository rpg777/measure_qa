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
    #t.test_files = FileList['measures/aedg_office_swh/tests/AedgOfficeSwh_test.rb']
    #t.warning = false
    #t.verbose = true
  end
end

task default: 'test:all'

# desc 'example test'
# Rake::TestTask.new('test:example') do |task|
#   #SimpleCov.command_name 'test:example'
#   task.test_files = FileList[
#   './../measures/plug_load_controls/tests/plug_load_controls_test.rb',
#   ]
# end

# desc 'example test 2'
# Rake::TestTask.new('test:example2') do |task|
#   task.pattern = 'measures/**/*_test.rb'
#   #SimpleCov.command_name 'test:example2'
# end



# require 'rake/testtask'
# desc 'Run all measure tests'
# Rake::TestTask.new('test:allofem') do |task|
#   task.libs << 'test'
#   task.test_files = FileList['measures/*/test/test_*.rb']
# end

require 'rubocop/rake_task'
desc 'Check the code for style consistency'
RuboCop::RakeTask.new(:run_rubocop) do |task|
  style_files = ["measures/**/measure.rb", "measures/**/*.rb"]
  task.options = ['--out=test/style/rubocop-results.xml']
  task.formatters = ['RuboCop::Formatter::CheckstyleFormatter']
  task.requires = ['rubocop/formatter/checkstyle_formatter']
  # don't abort rake on failure
  task.fail_on_error = false
end
