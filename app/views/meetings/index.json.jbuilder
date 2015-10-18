json.array!(@meetings) do |meeting|
  json.extract! meeting, :id, :meeting_location_id, :meeting_group_id, :name, :start_time
  json.url meeting_url(meeting, format: :json)
end
