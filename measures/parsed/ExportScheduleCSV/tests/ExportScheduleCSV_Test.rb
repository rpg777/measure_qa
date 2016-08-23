require 'openstudio'

require 'openstudio/ruleset/ShowRunnerOutput'

require "#{File.dirname(__FILE__)}/../measure.rb"

require 'fileutils'

require 'test/unit'

class ExportScheduleCSV_Test < Test::Unit::TestCase
    
  # paths to expected test files, includes osm 
  def modelPath
    return "#{File.dirname(__FILE__)}/ExampleModel.osm"
  end
  
  def runDir
    return "#{File.dirname(__FILE__)}/ExampleModel/"
  end
  
  def reportPath
    return "./report.csv"
  end
  
  def setup
    # check that the measure is not out of date
    measure_path = OpenStudio::system_complete(OpenStudio::Path.new("#{File.dirname(__FILE__)}/../"))
    measure = OpenStudio::BCLMeasure.new(measure_path)
    assert_equal("Export Schedule CSV", measure.name())
    if (measure.checkForUpdates())
      puts "Measure is out of date, automatically saving"
      measure.save()
    end
    assert((not measure.checkForUpdates()))
    
    # create test files if they do not exist
    if not File.exist?(modelPath())
      puts "Creating example model"
      model = OpenStudio::Model::exampleModel()
      model.save(OpenStudio::Path.new(modelPath()), true)
    end 
  end

  # delete test files, comment this out if you do not want to run EnergyPlus each time you run tests
  def teardown
    if File.exist?(modelPath())
      FileUtils.rm(modelPath())
    end
    if File.exist?(reportPath())
      FileUtils.rm(reportPath())
    end    
  end
  
  # the actual test
  def test_ExportScheduleCSV
     
    # check that the model path was created
    assert(File.exist?(modelPath()))
     
    # create an instance of the measure
    measure = ExportScheduleCSV.new
    
    # create an instance of a runner
    runner = OpenStudio::Ruleset::OSRunner.new
    
    # get arguments and test that they are what we are expecting
    arguments = measure.arguments()
    assert_equal(1, arguments.size)
    assert_equal("interval", arguments[0].name)

    # set argument values to bad values and run the measure
    argument_map = OpenStudio::Ruleset::OSArgumentMap.new
    measure.run(runner, argument_map)
    result = runner.result
    assert(result.value.valueName == "Fail")
    
    # set up runner, this will happen automatically when measure is run in PAT
    runner.setLastOpenStudioModelPath(OpenStudio::Path.new(modelPath()))       
       
    # set argument values to good values and run the measure
    argument_map = OpenStudio::Ruleset::OSArgumentMap.new
    argument_map["interval"] = arguments[0].clone
    
    measure.run(runner, argument_map)
    result = runner.result
    show_output(result)
    assert(result.value.valueName == "Success")
    assert(result.warnings.size == 0)
    assert(result.info.size == 1)
    
    assert(File.exist?(reportPath()))
  end  

end
