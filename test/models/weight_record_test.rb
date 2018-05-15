require 'test_helper'

class WeightRecordTest < ActiveSupport::TestCase
  def setup
    @weightRecord = WeightRecord.new(value: 123, noOfCatFans: 20, noOfDogFans: 34)
  end

  test "should be valid" do
    assert @weightRecord.valid?
  end

  test "value should be present" do
    @weightRecord.value = nil
    assert_not @weightRecord.valid?
  end

  test "value should be unique" do
    duplicate_wr = @weightRecord.dup
    @weightRecord.save
    assert_not duplicate_wr.valid?
  end

  test "number of cat fans should be present" do
    @weightRecord.noOfCatFans = nil
    assert_not @weightRecord.valid?
  end

  test "number of dog fans should be present" do
    @weightRecord.noOfDogFans = nil
    assert_not @weightRecord.valid?
  end

end
