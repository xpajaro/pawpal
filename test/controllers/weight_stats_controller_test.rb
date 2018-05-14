require 'test_helper'

class WeightStatsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @weight_stat = weight_stats(:one)
  end

  test "should get index" do
    get weight_stats_url
    assert_response :success
  end

  test "should get new" do
    get new_weight_stat_url
    assert_response :success
  end

  test "should create weight_stat" do
    assert_difference('WeightStat.count') do
      post weight_stats_url, params: { weight_stat: { noOfCatFans: @weight_stat.noOfCatFans, noOfDogFans: @weight_stat.noOfDogFans, weight: @weight_stat.weight } }
    end

    assert_redirected_to weight_stat_url(WeightStat.last)
  end

  test "should show weight_stat" do
    get weight_stat_url(@weight_stat)
    assert_response :success
  end

  test "should get edit" do
    get edit_weight_stat_url(@weight_stat)
    assert_response :success
  end

  test "should update weight_stat" do
    patch weight_stat_url(@weight_stat), params: { weight_stat: { noOfCatFans: @weight_stat.noOfCatFans, noOfDogFans: @weight_stat.noOfDogFans, weight: @weight_stat.weight } }
    assert_redirected_to weight_stat_url(@weight_stat)
  end

  test "should destroy weight_stat" do
    assert_difference('WeightStat.count', -1) do
      delete weight_stat_url(@weight_stat)
    end

    assert_redirected_to weight_stats_url
  end
end
