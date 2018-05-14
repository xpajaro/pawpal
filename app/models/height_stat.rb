class HeightStat < ApplicationRecord
    validates :height, presence: true
    validates :noOfDogFans, presence: true 
    validates :noOfCatFans, presence: true
end
