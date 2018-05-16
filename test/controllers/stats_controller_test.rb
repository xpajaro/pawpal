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

  test "should get stats table" do
    get "#{api_v1_stats_table_url}?height=54&weight=160"
    
    responseBody = JSON.parse(@response.body)
    assert_response :success
    assert_equal  ResponseWrapper::RESPONSE_PASS, responseBody['status'], "Invalid JSON"
  end

  test "calculation gives StatsTable" do
  
  end

  test "can get similar records " do
  
  end

end
