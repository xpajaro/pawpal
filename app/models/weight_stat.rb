class WeightStat < ApplicationRecord
    validates :weight, presence: true
    validates :noOfDogFans, presence: true 
    validates :noOfCatFans, presence: true
end
