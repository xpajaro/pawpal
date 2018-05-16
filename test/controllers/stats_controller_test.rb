require 'test_helper'

class StatsControllerTest < ActionDispatch::IntegrationTest
  def setup 
    WeightRecord.new(value: 125, noOfCatFans: 30, noOfDogFans: 60)
    HeightRecord.new(value: 69, noOfCatFans: 7, noOfDogFans: 6)
  end

  test "should get weight" do
    get api_v1_stats_weight_url

    assert_response :success
  end

  test "should get height" do
    get api_v1_stats_height_url

    assert_response :success
  end

  test "should get stats table" do
    get "#{api_v1_stats_table_url}?height=54&weight=160"
    
    responseBody = JSON.parse(@response.body)
    assert_response :success
    assert_equal  ResponseWrapper::RESPONSE_PASS, responseBody['status'], "Invalid response status"
  end

  test "should post confirmation if new" do

    post api_v1_stats_confirm_url, params: {weight:146, height:65, pet: 'dog'}

    responseBody = JSON.parse(@response.body)
    weightRecord = WeightRecord.find_by(value: 146)
    heightRecord = HeightRecord.find_by(value: 65)

    assert_response :success
    assert_equal  ResponseWrapper::RESPONSE_PASS, responseBody['status'], "Invalid response status"
    assert_equal 0, weightRecord.noOfCatFans, "pet record count incorrectly updated"
    assert_equal 1, weightRecord.noOfDogFans, "pet record count not updated"
    assert_equal 0, heightRecord.noOfCatFans, "pet record count incorrectly updated"
    assert_equal 1, heightRecord.noOfDogFans, "pet record count not updated"
  end

  test "should post confirmation if existing" do
    tempWR = WeightRecord.new(value: 200, noOfCatFans:10, noOfDogFans:20)
    tempHR = HeightRecord.new(value: 60, noOfCatFans:40, noOfDogFans:10)

    tempWR.save
    tempHR.save

    post api_v1_stats_confirm_url, params: {weight:200, height:60, pet: 'cat'}

    responseBody = JSON.parse(@response.body)
    weightRecord = WeightRecord.find_by(value: 200)
    heightRecord = HeightRecord.find_by(value: 60)

    assert_response :success
    assert_equal  ResponseWrapper::RESPONSE_PASS, responseBody['status'], "Invalid response status"
    assert_equal 11, weightRecord.noOfCatFans, "pet record count not updated"
    assert_equal 20, weightRecord.noOfDogFans, "pet record count incorrectly updated"
    assert_equal 41, heightRecord.noOfCatFans, "pet record count not updated"
    assert_equal 10, heightRecord.noOfDogFans, "pet record count incorrectly updated"
  end


  test "calculation gives StatsTable" do
  
  end

  test "can get similar records " do
  
  end

end
