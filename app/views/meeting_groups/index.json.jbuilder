json.array!(@meeting_groups) do |meeting_group|
  json.extract! meeting_group, :id, :name
  json.url meeting_group_url(meeting_group, format: :json)
end
