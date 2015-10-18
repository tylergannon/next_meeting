class Meeting < ActiveRecord::Base
  belongs_to :location, class_name: 'MeetingLocation', foreign_key: 'meeting_location_id'
  belongs_to :group, class_name: 'MeetingGroup', foreign_key: 'meeting_group_id'
end
