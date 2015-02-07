json.array!(@driver_trips) do |driver_trip|
  json.extract! driver_trip, :id, :start, :end, :isCurrent, :currentPosition, :Driver_id
  json.url driver_trip_url(driver_trip, format: :json)
end
