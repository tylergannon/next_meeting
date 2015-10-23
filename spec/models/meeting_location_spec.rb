require 'rails_helper'

RSpec.describe MeetingLocation, type: :model do
  subject {FactoryGirl.create :meeting_location}
  it {is_expected.to have_many(:meetings)}
  validates_presence_of! :name, :address1, :city, :postal_code

  describe "#complete_address" do
    let(:meeting_location) {FactoryGirl.create :meeting_location,
                            address1: '2129 Crosspoint Ave',
                            address2: 'Apt 23',
                            city: 'Santa Rosa',
                            state: 'CA', postal_code: '95403'}
    subject {meeting_location.full_address}
    it {is_expected.to eq('2129 Crosspoint Ave Apt 23, Santa Rosa, CA, 95403')}
  end

  describe "geocode" do
    let(:meeting_location) {create :ungeocoded_meeting_location}
    it "does shis" do
      VCR.use_cassette 'geocoder/your basic meeting' do
        meeting_location.geocode
      end
    end
  end


  describe "#geocode!" do
    it "calls #geocode and then saves" do
      aggregate_failures do
        expect(subject).to receive(:geocode)
        expect(subject).to receive(:save!)
        subject.geocode!
      end
    end
  end
end
