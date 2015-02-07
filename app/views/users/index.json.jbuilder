json.array!(@users) do |user|
  json.extract! user, :id, :name, :email, :password, :mobile, :source, :device_id, :default_location
  json.url user_url(user, format: :json)
end
