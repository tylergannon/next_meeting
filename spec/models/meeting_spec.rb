require 'rails_helper'

RSpec.describe Meeting, type: :model do
  subject {FactoryGirl.create :meeting}
  it {is_expected.to belong_to(:location)}
  it {is_expected.to belong_to(:group)}
end
