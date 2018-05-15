class API::V1::StatsController < ApplicationController
  skip_before_action :verify_authenticity_token
  
  def weight
    weightRecords = WeightRecord.all
    render json: ResponseWrapper.new(weightRecords)
  end

  def table
    render json: ResponseWrapper.new(StatsTable.new)
  end

  def calculate(weightRecords, heightRecords)
    weightRecord = WeightRecord.find_by(value:params[:weight])
    heightRecord = HeightRecord.find_by(value:params[:height])

  end
end
