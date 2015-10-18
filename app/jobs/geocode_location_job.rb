class GeocodeLocationJob < ActiveJob::Base
  queue_as :default

  def perform(meeting_location)
    unless meeting_location.geocoded?
      meeting_location.geocode
    end
  end
end
