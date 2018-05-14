class HeightStatsController < ApplicationController
  before_action :set_height_stat, only: [:show, :edit, :update, :destroy]

  # GET /height_stats
  # GET /height_stats.json
  def index
    @height_stats = HeightStat.all
  end

  # GET /height_stats/1
  # GET /height_stats/1.json
  def show
  end

  # GET /height_stats/new
  def new
    @height_stat = HeightStat.new
  end

  # GET /height_stats/1/edit
  def edit
  end

  # POST /height_stats
  # POST /height_stats.json
  def create
    @height_stat = HeightStat.new(height_stat_params)

    respond_to do |format|
      if @height_stat.save
        format.html { redirect_to @height_stat, notice: 'Height stat was successfully created.' }
        format.json { render :show, status: :created, location: @height_stat }
      else
        format.html { render :new }
        format.json { render json: @height_stat.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /height_stats/1
  # PATCH/PUT /height_stats/1.json
  def update
    respond_to do |format|
      if @height_stat.update(height_stat_params)
        format.html { redirect_to @height_stat, notice: 'Height stat was successfully updated.' }
        format.json { render :show, status: :ok, location: @height_stat }
      else
        format.html { render :edit }
        format.json { render json: @height_stat.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /height_stats/1
  # DELETE /height_stats/1.json
  def destroy
    @height_stat.destroy
    respond_to do |format|
      format.html { redirect_to height_stats_url, notice: 'Height stat was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_height_stat
      @height_stat = HeightStat.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def height_stat_params
      params.require(:height_stat).permit(:height, :noOfDogFans, :noOfCatFans)
    end
end
