require 'openstudio'

require 'openstudio/ruleset/ShowRunnerOutput'

require "#{File.dirname(__FILE__)}/../measure.rb"

require 'minitest/autorun'

class ReportModelChanges_Test < MiniTest::Test

  
  def test_ReportModelChanges
     
    # create an instance of the measure
    measure = ReportModelChanges.new
    
    # create an instance of a runner
    runner = OpenStudio::Ruleset::OSRunner.new
    
    # load test model
    model_path = File.dirname(__FILE__) + "/MidriseApartment.osm"
    vt = OpenStudio::OSVersion::VersionTranslator.new
    model = vt.loadModel(model_path)
    assert((not model.empty?))
    model = model.get
    
    # second model for comparison
    model2_path = File.dirname(__FILE__) + "/MidriseApartment2.osm"
    
    # move to output directory
    output_path = File.dirname(__FILE__) + "/output/"
    if not Dir.exists?(output_path)
      Dir.mkdir(output_path)
    end
    Dir.chdir(output_path)
    
    # get arguments and test that they are what we are expecting
    arguments = measure.arguments(model)
    assert_equal(1, arguments.size)
    assert_equal("compare_model_path", arguments[0].name)
    assert((not arguments[0].hasDefaultValue))

    # set argument values to good values and run the measure on model with spaces
    argument_map = OpenStudio::Ruleset::OSArgumentMap.new
    compare_model_path = arguments[0].clone
    assert(compare_model_path.setValue(model2_path))
    argument_map["compare_model_path"] = compare_model_path
    
    measure.run(model, runner, argument_map)
    result = runner.result
    show_output(result)
    assert(result.value.valueName == "Success")

  end  

end
