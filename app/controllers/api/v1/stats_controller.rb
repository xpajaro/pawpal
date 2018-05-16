class API::V1::StatsController < ApplicationController
  skip_before_action :verify_authenticity_token

  SAMPLE_SPACE = 3
  
  def weight
    weightRecords = WeightRecord.all
    render json: ResponseWrapper.new(weightRecords)
  end

  def table

    jsonResponse = ResponseWrapper.new(nil, ResponseWrapper::RESPONSE_FAIL)

    begin
      weight = params[:weight].to_i
      height = params[:height].to_i

      jsonResponse.status = ResponseWrapper::RESPONSE_PASS
      jsonResponse.data = calculate(weight, height)
    rescue Exception => ex
      puts ex
      jsonResponse.status = ResponseWrapper::RESPONSE_FAIL
      jsonResponse.message = "invalid parameters" #most common issue for now
    ensure
      render json: jsonResponse
    end

  end

  def calculate(weight, height)
    petStatsTable  = StatsTable.new

    #find records for this weight and height 
    weightRecord = WeightRecord.find_by(value: weight)
    heightRecord = HeightRecord.find_by(value: height)

    similarWeightRecords, similarHeightRecords = getSimilarRecords(weight, height)

    petStatsTable.calculate(weightRecord, heightRecord, similarWeightRecords, similarHeightRecords)

  end


  #load records for similar weight and height
  #use sample space constant for range
  def getSimilarRecords(weight, height)
    similarWeightRecords = []
    similarHeightRecords = []

    (-SAMPLE_SPACE..SAMPLE_SPACE).each do |i|
      if i != 0
        similarWeightRecords.push(WeightRecord.find_by(value: weight + i))
        similarHeightRecords.push(HeightRecord.find_by(value: height + i))
      end
    end

    return similarWeightRecords, similarHeightRecords
  end



end
