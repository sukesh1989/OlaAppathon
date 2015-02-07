class DriverTripSeatsController < ApplicationController
  before_action :set_driver_trip_seat, only: [:show, :edit, :update, :destroy]

  # GET /driver_trip_seats
  # GET /driver_trip_seats.json
  def index
    @driver_trip_seats = DriverTripSeat.all
  end

  # GET /driver_trip_seats/1
  # GET /driver_trip_seats/1.json
  def show
  end

  # GET /driver_trip_seats/new
  def new
    @driver_trip_seat = DriverTripSeat.new
  end

  # GET /driver_trip_seats/1/edit
  def edit
  end

  # POST /driver_trip_seats
  # POST /driver_trip_seats.json
  def create
    @driver_trip_seat = DriverTripSeat.new(driver_trip_seat_params)

    respond_to do |format|
      if @driver_trip_seat.save
        format.html { redirect_to @driver_trip_seat, notice: 'Driver trip seat was successfully created.' }
        format.json { render :show, status: :created, location: @driver_trip_seat }
      else
        format.html { render :new }
        format.json { render json: @driver_trip_seat.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /driver_trip_seats/1
  # PATCH/PUT /driver_trip_seats/1.json
  def update
    respond_to do |format|
      if @driver_trip_seat.update(driver_trip_seat_params)
        format.html { redirect_to @driver_trip_seat, notice: 'Driver trip seat was successfully updated.' }
        format.json { render :show, status: :ok, location: @driver_trip_seat }
      else
        format.html { render :edit }
        format.json { render json: @driver_trip_seat.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /driver_trip_seats/1
  # DELETE /driver_trip_seats/1.json
  def destroy
    @driver_trip_seat.destroy
    respond_to do |format|
      format.html { redirect_to driver_trip_seats_url, notice: 'Driver trip seat was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_driver_trip_seat
      @driver_trip_seat = DriverTripSeat.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def driver_trip_seat_params
      params.require(:driver_trip_seat).permit(:from, :to, :seatsoccupied)
    end
end
