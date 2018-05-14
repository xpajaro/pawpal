require 'test_helper'

class HeightStatsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @height_stat = height_stats(:one)
  end

  test "should get index" do
    get height_stats_url
    assert_response :success
  end

  test "should get new" do
    get new_height_stat_url
    assert_response :success
  end

  test "should create height_stat" do
    assert_difference('HeightStat.count') do
      post height_stats_url, params: { height_stat: { height: @height_stat.height, noOfCatFans: @height_stat.noOfCatFans, noOfDogFans: @height_stat.noOfDogFans } }
    end

    assert_redirected_to height_stat_url(HeightStat.last)
  end

  test "should show height_stat" do
    get height_stat_url(@height_stat)
    assert_response :success
  end

  test "should get edit" do
    get edit_height_stat_url(@height_stat)
    assert_response :success
  end

  test "should update height_stat" do
    patch height_stat_url(@height_stat), params: { height_stat: { height: @height_stat.height, noOfCatFans: @height_stat.noOfCatFans, noOfDogFans: @height_stat.noOfDogFans } }
    assert_redirected_to height_stat_url(@height_stat)
  end

  test "should destroy height_stat" do
    assert_difference('HeightStat.count', -1) do
      delete height_stat_url(@height_stat)
    end

    assert_redirected_to height_stats_url
  end
end
