json.array!(@driver_trip_seats) do |driver_trip_seat|
  json.extract! driver_trip_seat, :id, :from, :to, :seatsoccupied
  json.url driver_trip_seat_url(driver_trip_seat, format: :json)
end
