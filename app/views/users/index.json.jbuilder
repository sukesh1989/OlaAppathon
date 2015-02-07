json.array!(@users) do |user|
  json.extract! user, :id, :name, :email, :password, :mobile, :source, :device_id, :defaultlat, :defaultlong
  json.url user_url(user, format: :json)
end
