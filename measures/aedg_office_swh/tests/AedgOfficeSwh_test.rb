require_relative '../../../test/minitest_helper'

require 'openstudio'
require 'openstudio/ruleset/ShowRunnerOutput'

require 'minitest/autorun'

require_relative '../measure.rb'

require 'fileutils'


class AedgOfficeSwh_Test < MiniTest::Test

  
  def test_AedgOfficeSwh
     
    # create an instance of the measure
    measure = AedgOfficeSwh.new
    
    # create an instance of a runner
    runner = OpenStudio::Ruleset::OSRunner.new

    # load the test model
    translator = OpenStudio::OSVersion::VersionTranslator.new
    path = OpenStudio::Path.new(File.dirname(__FILE__) + "/AEDG_HVAC_GenericTestModel_0225_a.osm")
    model = translator.loadModel(path)
    assert((not model.empty?))
    model = model.get
    
    # get arguments and test that they are what we are expecting
    arguments = measure.arguments(model)
    puts arguments
    assert_equal(2, arguments.size)
    assert_equal("costTotalSwhSystem", arguments[0].name)
    assert_equal("numberOfEmployees", arguments[1].name)
       
    # set argument values to good values and run the measure on model with spaces
    argument_map = OpenStudio::Ruleset::OSArgumentMap.new

    costTotalSwhSystem = arguments[0].clone
    assert(costTotalSwhSystem.setValue(10000.0))
    argument_map["costTotalSwhSystem"] = costTotalSwhSystem

    numberOfEmployees = arguments[1].clone
    assert(numberOfEmployees.hasDefaultValue)
    assert(numberOfEmployees.setValue(numberOfEmployees.defaultValueAsInteger))
    #assert(numberOfEmployees.setValue(123))
    argument_map["numberOfEmployees"] = numberOfEmployees

    measure.run(model, runner, argument_map)
    result = runner.result
    show_output(result)
    assert(result.value.valueName == "Success")
    #assert(result.warnings.size == 1)
    #assert(result.info.size == 2)

    # save the model in an output directory
    output_dir = File.expand_path('output', File.dirname(__FILE__))
    FileUtils.mkdir output_dir unless Dir.exist? output_dir
    model.save("#{output_dir}/test.osm", true)
  end  

end
