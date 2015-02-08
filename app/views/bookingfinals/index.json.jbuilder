json.array!(@bookingfinals) do |bookingfinal|
  json.extract! bookingfinal, :id, :useremail, :tripid
  json.url bookingfinal_url(bookingfinal, format: :json)
end
