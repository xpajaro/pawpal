class WeightStatsController < ApplicationController
  before_action :set_weight_stat, only: [:show, :edit, :update, :destroy]

  # GET /weight_stats
  # GET /weight_stats.json
  def index
    @weight_stats = WeightStat.all
  end

  # GET /weight_stats/1
  # GET /weight_stats/1.json
  def show
  end

  # GET /weight_stats/new
  def new
    @weight_stat = WeightStat.new
  end

  # GET /weight_stats/1/edit
  def edit
  end

  # POST /weight_stats
  # POST /weight_stats.json
  def create
    @weight_stat = WeightStat.new(weight_stat_params)

    respond_to do |format|
      if @weight_stat.save
        format.html { redirect_to @weight_stat, notice: 'Weight stat was successfully created.' }
        format.json { render :show, status: :created, location: @weight_stat }
      else
        format.html { render :new }
        format.json { render json: @weight_stat.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /weight_stats/1
  # PATCH/PUT /weight_stats/1.json
  def update
    respond_to do |format|
      if @weight_stat.update(weight_stat_params)
        format.html { redirect_to @weight_stat, notice: 'Weight stat was successfully updated.' }
        format.json { render :show, status: :ok, location: @weight_stat }
      else
        format.html { render :edit }
        format.json { render json: @weight_stat.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /weight_stats/1
  # DELETE /weight_stats/1.json
  def destroy
    @weight_stat.destroy
    respond_to do |format|
      format.html { redirect_to weight_stats_url, notice: 'Weight stat was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_weight_stat
      @weight_stat = WeightStat.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def weight_stat_params
      params.require(:weight_stat).permit(:weight, :noOfDogFans, :noOfCatFans)
    end
end
