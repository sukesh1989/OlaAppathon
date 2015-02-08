class BookingController < ApplicationController
    
    def getdriver

		@noofseats=params[:seats]
    	@fromlat=params[:fromlat]
    	@fromlong=params[:fromlong]
    	@tolat=params[:tolat]
    	@tolong=params[:tolong]
        @away=0
        @drivertripid=0

        @TripRoute=TripRoute.all

  		@TripRoute.each do |t|
  			
           @app_url='http://maps.googleapis.com/maps/api/directions/json?origin='+@fromlat+','+@fromlong+'&destination='+t["pointlat"]+','+t["pointlong"]

     	     @content=HTTParty.get(@app_url) 
            
           unless @content.nil?
      
            @val=@content["routes"][0]["legs"][0]["distance"]["value"]/1000.00 unless @content["routes"][0]["legs"][0]["distance"]["value"].nil?
            if @val <10
           		@away=@val
              print t["DriverTrip_id"]
           		@drivertripid=t["DriverTrip_id"]
           		break
           end
         end

  		end
    @d=DriverTripSeat.find(@drivertripid)





		respond_to do |format|
      
			format.json {render json: {:awaykm=>@away,:car=>@d}}
      	
        end
     	   
	
	      
        


    end







	def distance



        @app_url='http://maps.googleapis.com/maps/api/directions/json?origin='+params['userlat']+','+params[:userlong]+'&destination='+params[:driverlat]+','+params[:driverlong]

		@content=HTTParty.get(@app_url)


		

		respond_to do |format|
			format.json {render json: @content["routes"][0]["legs"][0]["distance"]["value"]/1000.00}
      	
        end

	end

   def create
   		 @app_url='http://maps.googleapis.com/maps/api/directions/json?origin='+params[:fromlat]+','+params[:fromlong]+'&destination='+params[:tolat]+','+params[:tolong]



		 @content=HTTParty.get(@app_url)

	     @content["routes"][0]["legs"][0]["steps"].each do |t|
	 	      

	 	      TripRoute.create(:DriverTrip_id=>params[:drivertripid],:pointlat=>t['end_location']['lat'].to_s,:pointlong=>t['end_location']['lng'].to_s)
        end

		 respond_to do |format|
			format.json {render json: @content["routes"][0]["legs"][0]["steps"][0]['end_location']}
      	
        end

   end



	def show
	end


end
