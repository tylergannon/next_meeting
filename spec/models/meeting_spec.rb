require 'rails_helper'

RSpec.describe Meeting, type: :model do
  subject {FactoryGirl.create :meeting}
  it {is_expected.to belong_to(:location)}
  it {is_expected.to belong_to(:group)}
  it {is_expected.to validate_presence_of(:name)}
  it {is_expected.to validate_presence_of(:start_time)}
  it {is_expected.to validate_presence_of(:location)}
  it {is_expected.to have_and_belong_to_many(:weekdays)}

  it "is expected to validate at least one weekday" do
    subject.weekdays.clear
    aggregate_failures do
      expect(subject).not_to be_valid
      expect(subject.errors[:weekdays]).to include("Please choose at least one day of the week")
    end
  end
end
