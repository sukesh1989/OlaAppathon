class DriverTripsController < ApplicationController
  before_action :set_driver_trip, only: [:show, :edit, :update, :destroy]

  # GET /driver_trips
  # GET /driver_trips.json
  def index
    @driver_trips = DriverTrip.all
  end

  # GET /driver_trips/1
  # GET /driver_trips/1.json
  def show
  end

  # GET /driver_trips/new
  def new
    @driver_trip = DriverTrip.new
  end

  # GET /driver_trips/1/edit
  def edit
  end

  # POST /driver_trips
  # POST /driver_trips.json
  def create
    @driver_trip = DriverTrip.new(driver_trip_params)

    respond_to do |format|
      if @driver_trip.save
        format.html { redirect_to @driver_trip, notice: 'Driver trip was successfully created.' }
        format.json { render :show, status: :created, location: @driver_trip }
      else
        format.html { render :new }
        format.json { render json: @driver_trip.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /driver_trips/1
  # PATCH/PUT /driver_trips/1.json
  def update
    respond_to do |format|
      if @driver_trip.update(driver_trip_params)
        format.html { redirect_to @driver_trip, notice: 'Driver trip was successfully updated.' }
        format.json { render :show, status: :ok, location: @driver_trip }
      else
        format.html { render :edit }
        format.json { render json: @driver_trip.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /driver_trips/1
  # DELETE /driver_trips/1.json
  def destroy
    @driver_trip.destroy
    respond_to do |format|
      format.html { redirect_to driver_trips_url, notice: 'Driver trip was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_driver_trip
      @driver_trip = DriverTrip.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def driver_trip_params
      params.require(:driver_trip).permit(:start, :end, :isCurrent, :currentPosition, :Driver_id)
    end
end
