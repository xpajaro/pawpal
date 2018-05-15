class StatsTable
  #where w is weight and h is height

  attr_accessor :preferedPet 
  attr_accessor :catFanConfidence, :dogFanConfidence
  attr_accessor :userMetricsConfidence, :similarMetricsConfidence


  #where importance measures the strength of values in calculation
  IMPORTANCE_OF_USER_METRICS = 0.8
  IMPORTANCE_OF_SIMILAR_METRICS = 0.2

  def initialize
    @preferedPet = nil
    @catFanConfidence = nil
    @dogFanConfidence = nil
    @userMetricsConfidence = nil
    @similarMetricsConfidence = nil
  end

  ## This is a greedy, parameterized algorithm (we can change constants to test for better fit)
  # where confidence is probability of choosing a pet
  # confidence is calculated by:
  #     p(choosingPet at current weight) + probability(choosingPet at current height)
  # to allow for zero probabilities, and give bias to similar measurements to user's
  # we calculate final confidence by:
  #     (confidence at user's measurements * importance) + (confidence at similar measurements * importance)
  # where importance is how much we want a measurement to influence the result.
  
  def calculate(wRecord, hRecord, similarWRecords, similarHRecords)
    @userMetricsConfidence = getUserMetricConfidence(wRecord, hRecord)
    @similarMetricsConfidence = getSimilarMetricConfidence(similarWRecords, similarHRecords)

    @catFanConfidence = (@userMetricsConfidence.catFanConfidence * IMPORTANCE_OF_USER_METRICS) +
    (@similarMetricsConfidence.catFanConfidence * IMPORTANCE_OF_SIMILAR_METRICS)
    
    @dogFanConfidence = (@userMetricsConfidence.dogFanConfidence * IMPORTANCE_OF_USER_METRICS) +
    (@similarMetricsConfidence.dogFanConfidence * IMPORTANCE_OF_SIMILAR_METRICS)

    @preferedPet = choosePet(@catFanConfidence, @dogFanConfidence)

    self

  end

  def choosePet(catFanConfidence, dogFanConfidence)
    pet = ''

    if catFanConfidence > dogFanConfidence
      pet = Constants::PET_CAT
    elsif catFanConfidence < dogFanConfidence
      pet = Constants::PET_DOG
    else
      pet = [Constants::PET_CAT, Constants::PET_DOG].sample
    end

  end


  def getUserMetricConfidence(wRecord, hRecord)
    weightConfidence = calculateFanConfidence(wRecord)
    heightConfidence = calculateFanConfidence(hRecord)

    FanConfidence.new(
    weightConfidence.catFanConfidence + heightConfidence.catFanConfidence,
    weightConfidence.dogFanConfidence + heightConfidence.dogFanConfidence)

  end

  def getSimilarMetricConfidence(similarWRecords, similarHRecords)
    similarWeightConfidence = aggregateFanConfidence(similarWRecords)
    similarHeightConfidence = aggregateFanConfidence(similarHRecords)

    FanConfidence.new(
    similarWeightConfidence.catFanConfidence + similarHeightConfidence.catFanConfidence,
    similarWeightConfidence.dogFanConfidence + similarHeightConfidence.dogFanConfidence)
  end

  # calculate confidence over a range of records
  def aggregateFanConfidence(records = [])
    aggCatFanConfidence = 0
    aggDogFanConfidence = 0

    if (records)
      records.each do |record|
        fanConfidence = calculateFanConfidence(record)
        aggCatFanConfidence += fanConfidence.catFanConfidence
        aggDogFanConfidence += fanConfidence.dogFanConfidence
      end
    end
    
    FanConfidence.new(aggCatFanConfidence, aggDogFanConfidence)

  end

  def calculateFanConfidence(record)
    catFanConfidence = 0
    dogFanConfidence = 0

    if record
      totalFans = record.noOfCatFans.to_f + record.noOfDogFans.to_f
      catFanConfidence = record.noOfCatFans/totalFans
      dogFanConfidence = record.noOfDogFans/totalFans
    end
  
    FanConfidence.new(catFanConfidence, dogFanConfidence)
  end

end