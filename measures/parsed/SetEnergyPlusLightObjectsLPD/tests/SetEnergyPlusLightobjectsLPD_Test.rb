require 'openstudio'

require 'openstudio/ruleset/ShowRunnerOutput'

require "#{File.dirname(__FILE__)}/../measure.rb"

require 'test/unit'

class SetEnergyPlusLightObjectsLPD_Test < MiniTest::Test

  
  def test_SetEnergyPlusLightObjectsLPD
     
    # create an instance of the measure
    measure = SetEnergyPlusLightObjectsLPD.new
    
    # create an instance of a runner
    runner = OpenStudio::Ruleset::OSRunner.new

    # load the test model
    translator = OpenStudio::OSVersion::VersionTranslator.new
    path = OpenStudio::Path.new(File.dirname(__FILE__) + "/EpLpdTest.osm")
    model = translator.loadModel(path)
    assert((not model.empty?))
    model = model.get

    # forward translate OSM file to IDF file
    ft = OpenStudio::EnergyPlus::ForwardTranslator.new
    workspace = ft.translateModel(model)
    
    # get arguments and test that they are what we are expecting
    arguments = measure.arguments(workspace)
       
    # set argument values to good values and run the measure on the workspace
    argument_map = OpenStudio::Ruleset::OSArgumentMap.new
    lpd = arguments[0].clone
    assert(lpd.setValue("10.76"))
    argument_map["lpd"] = lpd
    measure.run(workspace, runner, argument_map)
    result = runner.result
    show_output(result)
    assert(result.value.valueName == "Success")
    assert(result.warnings.size == 0)
    assert(result.info.size == 6)
    
  end
  

end