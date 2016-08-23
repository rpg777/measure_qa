require 'openstudio'

require 'openstudio/ruleset/ShowRunnerOutput'

require "#{File.dirname(__FILE__)}/../measure.rb"

require 'test/unit'

class SetEnergyPlusMinimumOutdoorAirFlowRate_Test < Test::Unit::TestCase

  
  def test_SetEnergyPlusMinimumOutdoorAirFlowRate
     
    # create an instance of the measure
    measure = SetEnergyPlusMinimumOutdoorAirFlowRate.new
    
    # create an instance of a runner
    runner = OpenStudio::Ruleset::OSRunner.new

    # load the test model
    translator = OpenStudio::OSVersion::VersionTranslator.new
    path = OpenStudio::Path.new(File.dirname(__FILE__) + "/Test.osm")
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
    minOutdoorAirFlow = arguments[0].clone
    assert(minOutdoorAirFlow.setValue("0.9999"))
    argument_map["minOutdoorAirFlow"] = minOutdoorAirFlow
    measure.run(workspace, runner, argument_map)
    result = runner.result
    show_output(result)
    assert(result.value.valueName == "Success")
    assert(result.warnings.size == 0)
    assert(result.info.size == 3)
    
  end
  

end