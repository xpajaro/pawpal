require 'test_helper'

class StatsTableTest < ActiveSupport::TestCase
  def setup
    @sampleWRecord =  WeightRecord.new(value: 123, noOfCatFans: 20, noOfDogFans: 50)
    @sampleWRecord2 =  WeightRecord.new(value: 124, noOfCatFans: 25, noOfDogFans: 55)
    @sampleWRecord3 =  WeightRecord.new(value: 125, noOfCatFans: 30, noOfDogFans: 60)
    @sampleWRecord4 =  WeightRecord.new(value: 125, noOfCatFans: 130, noOfDogFans: 60)
    
    @sampleWRecords = [@sampleWRecord, @sampleWRecord2, @sampleWRecord3]

    @sampleHRecord =  HeightRecord.new(value: 69, noOfCatFans: 7, noOfDogFans: 6)
    @sampleHRecord2 =  HeightRecord.new(value: 65, noOfCatFans: 13, noOfDogFans: 3)
    @sampleHRecord3 =  HeightRecord.new(value: 58, noOfCatFans: 12, noOfDogFans: 12)
    
    @sampleHRecords = [@sampleHRecord, @sampleHRecord2, @sampleHRecord3]

    @sampleTable = StatsTable.new
  end

  test "can calculate fan confidence" do
    fanConfidence = @sampleTable.calculateFanConfidence(@sampleWRecord)
  
    assert_equal  20/70.0, fanConfidence.catFanConfidence, "wrong cat confidence value"
    assert_equal  50/70.0, fanConfidence.dogFanConfidence,"wrong dog confidence value"
  end

  test "can calculate fan confidence with bad input" do
    fanConfidence = @sampleTable.calculateFanConfidence(nil)
    
    assert_equal 0.0, fanConfidence.catFanConfidence, "wrong cat confidence value"
    assert_equal 0.0, fanConfidence.dogFanConfidence, "wrong dog confidence value"
  end

  test "can aggregate fan confidence" do
    fanConfidence = @sampleTable.aggregateFanConfidence(@sampleWRecords)
    
    assert_equal (20/70.0 + 25/80.0 + 30/90.0), fanConfidence.catFanConfidence, "wrong cat confidence value"
    assert_equal (50/70.0 + 55/80.0 + 60/90.0), fanConfidence.dogFanConfidence, "wrong dog confidence value"
  end

  test "can get user metric confidence" do
    fanConfidence = @sampleTable.getUserMetricConfidence(@sampleWRecord, @sampleHRecord)
    
    assert_equal (20/70.0 + 7/13.0), fanConfidence.catFanConfidence,  "wrong cat confidence value"
    assert_equal (50/70.0 + 6/13.0), fanConfidence.dogFanConfidence, "wrong dog confidence value"
  end

  test "can get similar metric confidence" do
    fanConfidence = @sampleTable.getSimilarMetricConfidence(@sampleWRecords, @sampleHRecords)
    
    assert_equal (20/70.0 + 25/80.0 + 30/90.0) + (7/13.0 + 13/16.0 + 12/24.0), 
    fanConfidence.catFanConfidence, "wrong cat confidence value"
    
    assert_equal (50/70.0 + 55/80.0 + 60/90.0) + (6/13.0 + 3/16.0 + 12/24.0),
    fanConfidence.dogFanConfidence, "wrong dog confidence value"
  end

  test "can choose pet" do
    assert_equal  Constants::PET_CAT, @sampleTable.choosePet(0.85, 0.7), "didn't choose cat despite higher confidence"
    assert_equal  Constants::PET_DOG, @sampleTable.choosePet(0.15, 0.7), "didn't choose dog despite higher confidence"
  end

  test "can calculate pet choice with user data" do
    statsTable = @sampleTable.calculate(@sampleWRecord, @sampleHRecord, @sampleWRecords, @sampleHRecords) 

    assert_equal  Constants::PET_DOG, statsTable.preferedPet, "wrong pet choice calculated"
  end

  test "can calculate pet choice with no user data" do
    statsTable = @sampleTable.calculate(nil, nil, @sampleWRecords, @sampleHRecords) 

    assert_equal  Constants::PET_DOG, statsTable.preferedPet, "wrong pet choice calculated"
  end

  test "can calculate pet choice with no similar data" do
    statsTable = @sampleTable.calculate(@sampleWRecord4, @sampleHRecord, nil, nil) 

    assert_equal  Constants::PET_CAT, statsTable.preferedPet, "wrong pet choice calculated"
  end

  test "can calculate pet choice with no data" do
    statsTable = @sampleTable.calculate(nil, nil, nil, nil) 

    # puts "\n\n"
    # puts "usermetrics: #{statsTable.userMetricsConfidence.catFanConfidence} #{statsTable.userMetricsConfidence.dogFanConfidence}\n"
    # puts "similarmetrics: #{statsTable.similarMetricsConfidence.catFanConfidence} #{statsTable.similarMetricsConfidence.dogFanConfidence}\n"
    # puts "catFanConfidence: #{statsTable.catFanConfidence}\n"
    # puts "dogFanConfidence: #{statsTable.dogFanConfidence}\n"
    # puts "pet: #{statsTable.preferedPet} \n\n"

    assert [Constants::PET_CAT, Constants::PET_DOG].include? statsTable.preferedPet
  end

end