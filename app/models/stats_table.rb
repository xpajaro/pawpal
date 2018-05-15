class StatsTable
  #where w is weight and h is height

  PET_DOG = 'dog'
  PET_CAT = 'cat'

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

  def calculate(wRecord, hRecord, similarWRecords, similarHRecords)
    @userMetricsConfidence = getUserMetricConfidence(wRecord, hRecord)
    @similarMetricsConfidence = getSimilarMetricConfidence(similarWRecords, similarHRecords)

    @catFanConfidence = (@userMetricsConfidence.catFanConfidence * IMPORTANCE_OF_USER_METRICS) +
    (@similarMetricsConfidence.calculateFanConfidence * IMPORTANCE_OF_SIMILAR_METRICS)
    
    @dogFanConfidence = (@userMetricsConfidence.dogFanConfidence * IMPORTANCE_OF_USER_METRICS) +
    (@similarMetricsConfidence.calculateDogConfidence * IMPORTANCE_OF_SIMILAR_METRICS)

    @preferedPet = choosePet(@catFanConfidence, @dogFanConfidence)

    self

  end

  def choosePet(catFanConfidence, dogFanConfidence)
    pet = ''

    if catFanConfidence > dogFanConfidence
      pet = PET_CAT
    elsif catFanConfidence < dogFanConfidence
      pet = PET_DOG
    else
      pet = [PET_CAT, PET_DOG].sample
    end

  end


  def getUserMetricConfidence(wRecord, hRecord)
    weightConfidence = calculateFanConfidence(wRecord)
    heightConfidence = calculateFanConfidence(hRecord)

    return FanConfidence.new(
    weightConfidence.catFanConfidence + heightConfidence.catFanConfidence,
    weightConfidence.dogFanConfidence + heightConfidence.dogFanConfidence)

  end

  def getSimilarMetricConfidence(similarWRecords, similarHRecords)
    similarWeightConfidence = aggregateFanConfidence(similarWRecords)
    similarHeightConfidence = aggregateFanConfidence(similarHRecords)

    return FanConfidence.new(
    similarWeightConfidence.catFanConfidence + similarHeightConfidence.catFanConfidence,
    similarWeightConfidence.dogFanConfidence + similarHeightConfidence.dogFanConfidence)
  end

  # calculate confidence over a range of records
  def aggregateFanConfidence(records)
    aggCatFanConfidence = 0
    aggDogFanConfidence = 0

    records.each do |record|
      catFanConfidence, dogFanConfidence = calculateFanConfidence(record)
      aggCatFanConfidence += catFanConfidence
      aggDogFanConfidence += dogFanConfidence
    end

    return FanConfidence.new(aggCatFanConfidence, aggDogFanConfidence)

  end

  def calculateFanConfidence(record)
    catFanConfidence = 0
    dogFanConfidence = 0

    if record
      totalFans = record.noOfCatFans + record.noOfDogFans
      catFanConfidence = record.noOfCatFans/totalFans
      dogFanConfidence = record.noOfDogFans/totalFans
    end
  
    return FanConfidence.new(catFanConfidence, dogFanConfidence)
  end

end