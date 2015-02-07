class DriverTripRoutesController < ApplicationController
  before_action :set_driver_trip_route, only: [:show, :edit, :update, :destroy]

  # GET /driver_trip_routes
  # GET /driver_trip_routes.json
  def index
    @driver_trip_routes = DriverTripRoute.all
  end

  # GET /driver_trip_routes/1
  # GET /driver_trip_routes/1.json
  def show
  end

  # GET /driver_trip_routes/new
  def new
    @driver_trip_route = DriverTripRoute.new
  end

  # GET /driver_trip_routes/1/edit
  def edit
  end

  # POST /driver_trip_routes
  # POST /driver_trip_routes.json
  def create
    @driver_trip_route = DriverTripRoute.new(driver_trip_route_params)

    respond_to do |format|
      if @driver_trip_route.save
        format.html { redirect_to @driver_trip_route, notice: 'Driver trip route was successfully created.' }
        format.json { render :show, status: :created, location: @driver_trip_route }
      else
        format.html { render :new }
        format.json { render json: @driver_trip_route.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /driver_trip_routes/1
  # PATCH/PUT /driver_trip_routes/1.json
  def update
    respond_to do |format|
      if @driver_trip_route.update(driver_trip_route_params)
        format.html { redirect_to @driver_trip_route, notice: 'Driver trip route was successfully updated.' }
        format.json { render :show, status: :ok, location: @driver_trip_route }
      else
        format.html { render :edit }
        format.json { render json: @driver_trip_route.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /driver_trip_routes/1
  # DELETE /driver_trip_routes/1.json
  def destroy
    @driver_trip_route.destroy
    respond_to do |format|
      format.html { redirect_to driver_trip_routes_url, notice: 'Driver trip route was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_driver_trip_route
      @driver_trip_route = DriverTripRoute.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def driver_trip_route_params
      params.require(:driver_trip_route).permit(:pointlat, :pointlong, :DriverTrip_id)
    end
end
