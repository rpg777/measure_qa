require 'openstudio'

require 'openstudio/ruleset/ShowRunnerOutput'

require "#{File.dirname(__FILE__)}/../measure.rb"

require 'test/unit'

class AssignSpaceTypeBySpaceName_Test < MiniTest::Test

  
  def test_AssignSpaceTypeBySpaceName_skipAssigned
     
    # create an instance of the measure
    measure = AssignSpaceTypeBySpaceName.new
    
    # create an instance of a runner
    runner = OpenStudio::Ruleset::OSRunner.new

    # load the test model
    translator = OpenStudio::OSVersion::VersionTranslator.new
    path = OpenStudio::Path.new(File.dirname(__FILE__) + "/ImportedIdf_TestModel.osm")
    model = translator.loadModel(path)
    assert((not model.empty?))
    model = model.get
    
    # get arguments and test that they are what we are expecting
    arguments = measure.arguments(model)

    # set argument values to good values and run the measure on model with spaces
    argument_map = OpenStudio::Ruleset::OSArgumentMap.new

    search_string = arguments[0].clone
    assert(search_string.setValue("Corridor"))
    argument_map["search_string"] = search_string

    space_type = arguments[1].clone
    assert(space_type.setValue("189.1-2009 - LrgHotel - Corridor - CZ1-3"))
    argument_map["space_type"] = space_type

    skip_already_assigned = arguments[2].clone
    assert(skip_already_assigned.setValue(true))
    argument_map["skip_already_assigned"] = skip_already_assigned

    measure.run(model, runner, argument_map)
    result = runner.result
    show_output(result)
    assert(result.value.valueName == "Success")
    #assert(result.warnings.size == 1)
    #assert(result.info.size == 2)

    #save the model
    output_file_path = OpenStudio::Path.new(File.dirname(__FILE__) + "/test.osm")
    model.save(output_file_path,true)

  end

  def test_AssignSpaceTypeBySpaceName

    # create an instance of the measure
    measure = AssignSpaceTypeBySpaceName.new

    # create an instance of a runner
    runner = OpenStudio::Ruleset::OSRunner.new

    # load the test model
    translator = OpenStudio::OSVersion::VersionTranslator.new
    path = OpenStudio::Path.new(File.dirname(__FILE__) + "/ImportedIdf_TestModel.osm")
    model = translator.loadModel(path)
    assert((not model.empty?))
    model = model.get

    # get arguments and test that they are what we are expecting
    arguments = measure.arguments(model)

    # set argument values to good values and run the measure on model with spaces
    argument_map = OpenStudio::Ruleset::OSArgumentMap.new

    search_string = arguments[0].clone
    assert(search_string.setValue("Corridor"))
    argument_map["search_string"] = search_string

    space_type = arguments[1].clone
    assert(space_type.setValue("189.1-2009 - LrgHotel - Corridor - CZ1-3"))
    argument_map["space_type"] = space_type

    skip_already_assigned = arguments[2].clone
    assert(skip_already_assigned.setValue(false))
    argument_map["skip_already_assigned"] = skip_already_assigned

    measure.run(model, runner, argument_map)
    result = runner.result
    #show_output(result)
    assert(result.value.valueName == "Success")
    #assert(result.warnings.size == 1)
    #assert(result.info.size == 2)

    #save the model
    #output_file_path = OpenStudio::Path.new(File.dirname(__FILE__) + "/test.osm")
    #model.save(output_file_path,true)

  end

end
