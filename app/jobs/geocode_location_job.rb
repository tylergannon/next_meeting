class GeocodeLocationJob < ActiveJob::Base
  queue_as :default

  def perform(meeting_location)
    unless meeting_location.geocoded?
      meeting_location.geocode!
    end
    if MeetingLocation.in_the_same_place_as(meeting_location).exists?
      merge_duplicate_meeting_location(meeting_location)
    end
  end

  def merge_duplicate_meeting_location(meeting_location)
    Meeting.with_advisory_lock('Move Meetings') do
      MeetingLocation.with_advisory_lock('Remove redundant location') do
        identical_location = MeetingLocation.in_the_same_place_as(meeting_location).first

        if identical_location
          Meeting.transaction do
            Meeting.where(meeting_location_id: meeting_location.id).update_all(
              meeting_location_id: identical_location.id
            )
            meeting_location.destroy
          end
        end
      end
    end
  end
end
