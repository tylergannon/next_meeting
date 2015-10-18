require 'rails_helper'

RSpec.describe GeocodeLocationJob, type: :job do
  let(:latitude) {35.22}
  let(:longitude) {-122.35}
  let(:location){create :meeting_location}
  subject{GeocodeLocationJob.new}
  let(:meeting) {create :meeting, location: location}
  describe "when the location is not geocoded" do
    it "should call geocode on the location" do
      # another_location = create :meeting_location, latitude: latidude, longitude: longitude
      aggregate_failures do
        expect(location).not_to be_geocoded
        expect(location).to receive(:geocode!)
        subject.perform(location)
      end
    end
  end

  describe "when the location has been geocoded already" do
    let(:location){create :meeting_location, latitude: latitude, longitude: longitude}
    it "should NOT call geocode on the location" do
      # another_location = create :meeting_location, latitude: latidude, longitude: longitude
      aggregate_failures do
        expect(location).to be_geocoded
        expect(location).not_to receive(:geocode!)
        subject.perform(location)
      end
    end
  end

  describe "when there is another MeetingLocation at the same lat, lon" do
    let(:location){create :meeting_location, latitude: latitude, longitude: longitude}
    let(:another_location) {create :meeting_location, latitude: latitude, longitude: longitude}
    before {another_location}
    it "sets the meetings for this location, to the other, and destroys this one" do
      aggregate_failures do
        expect(meeting.location).to eq(location)
        expect(MeetingLocation.in_the_same_place_as(location)).to exist
        expect(subject).to receive(:merge_duplicate_meeting_location).with(location).and_call_original
        expect(location).not_to receive(:geocode)

        subject.perform(location)
        meeting.reload

        expect(meeting.location).to eq(another_location)
        expect(MeetingLocation.where(id: location.id)).not_to exist
      end
    end

    it "Sets a mutex on MeetingLocation and Meeting tables during the transaction" do
      aggregate_failures do
        expect(MeetingLocation).to receive(:with_advisory_lock).and_call_original
        expect(Meeting).to receive(:with_advisory_lock).and_call_original
        subject.perform(location)
      end
    end
  end
end
