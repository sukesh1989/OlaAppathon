class TripRoutesController < ApplicationController
  before_action :set_trip_route, only: [:show, :edit, :update, :destroy]

  # GET /trip_routes
  # GET /trip_routes.json
  def index
    @trip_routes = TripRoute.all
  end

  # GET /trip_routes/1
  # GET /trip_routes/1.json
  def show
  end

  # GET /trip_routes/new
  def new
    @trip_route = TripRoute.new
  end

  # GET /trip_routes/1/edit
  def edit
  end

  # POST /trip_routes
  # POST /trip_routes.json
  def create
    @trip_route = TripRoute.new(trip_route_params)

    respond_to do |format|
      if @trip_route.save
        format.html { redirect_to @trip_route, notice: 'Trip route was successfully created.' }
        format.json { render :show, status: :created, location: @trip_route }
      else
        format.html { render :new }
        format.json { render json: @trip_route.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /trip_routes/1
  # PATCH/PUT /trip_routes/1.json
  def update
    respond_to do |format|
      if @trip_route.update(trip_route_params)
        format.html { redirect_to @trip_route, notice: 'Trip route was successfully updated.' }
        format.json { render :show, status: :ok, location: @trip_route }
      else
        format.html { render :edit }
        format.json { render json: @trip_route.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /trip_routes/1
  # DELETE /trip_routes/1.json
  def destroy
    @trip_route.destroy
    respond_to do |format|
      format.html { redirect_to trip_routes_url, notice: 'Trip route was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_trip_route
      @trip_route = TripRoute.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def trip_route_params
      params.require(:trip_route).permit(:pointlat, :pointlong, :DriverTrip_id)
    end
end
