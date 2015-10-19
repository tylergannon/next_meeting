json.array!(@meetings) do |meeting|
  json.extract! meeting, :id, :name, :formatted_start_time, :formatted_days
  json.location do
    json.name meeting.location.name
    json.address1 meeting.location.address1
    json.address2 meeting.location.address2
    json.city meeting.location.city
    json.state meeting.location.state
    json.postal_code meeting.location.postal_code
    json.latitude meeting.location.latitude
    json.longitude meeting.location.longitude
    json.notes meeting.location.notes
    json.distance meeting.location.distance_from(*@user_location)
  end
  json.url meeting_url(meeting, format: :json)
end
