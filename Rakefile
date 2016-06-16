
# require 'bundler/gem_tasks'
# begin
#   Bundler.setup
# rescue Bundler::BundlerError => e
#   $stderr.puts e.message
#   $stderr.puts 'Run `bundle install` to install missing gems'
#   exit e.status_code
# end

require 'rake/testtask'
desc 'Run test group 0'
Rake::TestTask.new('test:example') do |task|
  task.test_files = FileList[
  'measures/plug_load_controls/tests/plug_load_controls_test.rb',
  ]
end

# require 'rake/testtask'
# desc 'Run all measure tests'
# Rake::TestTask.new('test:allofem') do |task|
#   task.libs << 'test'
#   task.test_files = FileList['measures/*/test/test_*.rb']
# end

# require 'rake/testtask'
# desc 'Run the measure tests'
# Rake::TestTask.new('test:measures') do |task|
#   task.test_files = FileList[
#   # TOO LONG 'measures/apply_system1/tests/full_hvac_test.rb',
#   'measures/btap_apply_necb_rules/tests/apply_necb_rules_Test.rb',
#   # TOO LONG 'measures/btap_campus_classic/tests/btap_coldlake_classic_test.rb',
#   'measures/btap_change_building_location/tests/btap_change_location_test.rb',
#   'measures/btap_create_doe_necb_models/tests/DOE2NECB_Model_Test.rb',
#   'measures/btap_equest_converter/tests/btap_equest_converter_test.rb',
#   'measures/btap_replace_model/tests/ReplaceModel_Test.rb',
#   'measures/btap_set_default_construction_set/tests/set_default_construction_set_test.rb',
#   # TOO Long 'measures/create_DOE_prototype_building/tests/create_DOE_prototype_building_test.rb',
#   'measures/UtilityTariffs/tests/UtilityTariffs_Test.rb'
#   ]
# end

# require 'rubocop/rake_task'
# desc 'Check the code for style consistency'
# RuboCop::RakeTask.new(:rubocop) do |task|
#   task.options = ['--no-color', '--out=rubocop-results.xml']
#   task.formatters = ['RuboCop::Formatter::CheckstyleFormatter']
#   task.requires = ['rubocop/formatter/checkstyle_formatter']
#   # don't abort rake on failure
#   task.fail_on_error = false
# end
