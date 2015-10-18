json.array!(@meeting_locations) do |meeting_location|
  json.extract! meeting_location, :id, :name, :address1, :address2, :city, :state, :postal_code, :latitude, :longitude, :notes
  json.url meeting_location_url(meeting_location, format: :json)
end
