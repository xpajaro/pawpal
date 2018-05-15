class WeightRecord < ApplicationRecord
  validates :value, presence: true, uniqueness: true
  validates :noOfCatFans, presence: true
  validates :noOfDogFans, presence: true
end
