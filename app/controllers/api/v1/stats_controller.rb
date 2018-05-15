class API::V1::StatsController < ApplicationController
  skip_before_action :verify_authenticity_token

  SAMPLE_SPACE = 3
  
  def weight
    weightRecords = WeightRecord.all
    render json: ResponseWrapper.new(weightRecords)
  end

  def table
    weight = params[:weight]
    height = params[:height]
    
    response = StatsTable.new

    if weight and height
      response = calculate(weight, height)
      render json: ResponseWrapper.new(response)
    else
      render json: ResponseWrapper.new(response, ResponseWrapper::RESPONSE_FAIL, "parameters incomplete")
    end

  end

  def calculate(weight, height)
    
    #find records for this weight and height 
    weightRecord = WeightRecord.find_by(value:weight)
    heightRecord = HeightRecord.find_by(value:height)

    #load records for similar weight and height
    #use sample space constant for range
    similarWeightRecords = []
    similarHeightRecords = []

    (-SAMPLE_SPACE..SAMPLE_SPACE).each do |i|
      if i != 0
        puts i, weight
        similarWeightRecords.push(WeightRecord.find_by(value:params[weight + i]))
        similarHeightRecords.push(HeightRecord.find_by(value:params[height + i]))
      end
    end

    StatsTable.calculate(weightRecord, heightRecord, similarWeightRecords, similarHeightRecords)

  end


end
