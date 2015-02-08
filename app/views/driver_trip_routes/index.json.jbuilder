json.array!(@driver_trip_routes) do |driver_trip_route|
  json.extract! driver_trip_route, :id, :pointlat, :pointlong, :DriverTrip_id
  json.url driver_trip_route_url(driver_trip_route, format: :json)
end
