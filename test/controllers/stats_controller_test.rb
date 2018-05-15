require 'test_helper'

class StatsControllerTest < ActionDispatch::IntegrationTest
  def setup 
  end

  test "should get weight" do
    get api_v1_stats_weight_url

    assert_response :success
  end

  test "should get stats table" do
    get api_v1_stats_table_url
    assert_response :success
  end

end
