json.array!(@drivers) do |driver|
  json.extract! driver, :id, :name, :mobile, :currentlocation
  json.url driver_url(driver, format: :json)
end
