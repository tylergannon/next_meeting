FactoryGirl.define do
  factory :meeting do
    association :location, factory: :meeting_location
    association :group, factory: :meeting_group
name "MyString"
start_time "2015-10-18 13:52:42"
  end

end
