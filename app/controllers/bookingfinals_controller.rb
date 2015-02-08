class BookingfinalsController < ApplicationController
  before_action :set_bookingfinal, only: [:show, :edit, :update, :destroy]

  # GET /bookingfinals
  # GET /bookingfinals.json
  def index
    @bookingfinals = Bookingfinal.all
  end

  # GET /bookingfinals/1
  # GET /bookingfinals/1.json
  def show
  end

  # GET /bookingfinals/new
  def new
    @bookingfinal = Bookingfinal.new
  end

  # GET /bookingfinals/1/edit
  def edit
  end

  # POST /bookingfinals
  # POST /bookingfinals.json
  def create
    @bookingfinal = Bookingfinal.new(bookingfinal_params)

    respond_to do |format|
      if @bookingfinal.save
        format.html { redirect_to @bookingfinal, notice: 'Bookingfinal was successfully created.' }
        format.json { render :show, status: :created, location: @bookingfinal }
      else
        format.html { render :new }
        format.json { render json: @bookingfinal.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /bookingfinals/1
  # PATCH/PUT /bookingfinals/1.json
  def update
    respond_to do |format|
      if @bookingfinal.update(bookingfinal_params)
        format.html { redirect_to @bookingfinal, notice: 'Bookingfinal was successfully updated.' }
        format.json { render :show, status: :ok, location: @bookingfinal }
      else
        format.html { render :edit }
        format.json { render json: @bookingfinal.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /bookingfinals/1
  # DELETE /bookingfinals/1.json
  def destroy
    @bookingfinal.destroy
    respond_to do |format|
      format.html { redirect_to bookingfinals_url, notice: 'Bookingfinal was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_bookingfinal
      @bookingfinal = Bookingfinal.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def bookingfinal_params
      params.require(:bookingfinal).permit(:useremail, :tripid)
    end
end
