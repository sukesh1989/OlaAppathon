json.array!(@trip_routes) do |trip_route|
  json.extract! trip_route, :id, :pointlat, :pointlong, :DriverTrip_id
  json.url trip_route_url(trip_route, format: :json)
end
