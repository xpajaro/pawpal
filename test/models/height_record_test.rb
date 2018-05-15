require 'test_helper'

class HeightRecordTest < ActiveSupport::TestCase
  def setup
    @heightRecord = HeightRecord.new(value: 123, noOfCatFans: 20, noOfDogFans: 34)
  end

  test "should be valid" do
    assert @heightRecord.valid?
  end

  test "value should be present" do
    @heightRecord.value = nil
    assert_not @heightRecord.valid?
  end

  test "value should be unique" do
    duplicate_hr = @heightRecord.dup
    @heightRecord.save
    assert_not duplicate_hr.valid?
  end

  test "number of cat fans should be present" do
    @heightRecord.noOfCatFans = nil
    assert_not @heightRecord.valid?
  end

  test "number of dog fans should be present" do
    @heightRecord.noOfDogFans = nil
    assert_not @heightRecord.valid?
  end
end
