require 'rails_helper'

RSpec.describe MeetingGroup, type: :model do
  subject{ FactoryGirl.create :meeting_group }
  it {is_expected.to have_many(:meetings)}
  it {is_expected.to validate_presence_of(:name)}
end
