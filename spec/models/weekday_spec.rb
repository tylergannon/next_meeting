require 'rails_helper'

RSpec.describe Weekday, type: :model do
  subject {Weekday.first}
  it {is_expected.to have_and_belong_to_many(:meetings)}
end
