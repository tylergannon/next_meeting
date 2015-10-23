FactoryGirl.define do
  factory :meeting_location do
    name "A Place"
    address1 "2129 Crosspoint Ave"
    address2 nil
    city "Santa Rosa"
    state "CA"
    postal_code "95403"
    notes "MyString"
    latlon "POINT (-122.755528 38.455411)"

    transient do
      latitude nil
      longitude nil
    end

    after :create do |model, evaluator|
      if evaluator.latitude
        model.update latlon: "POINT(#{evaluator.longitude} #{evaluator.latitude})"
      end
    end

    factory :ungeocoded_meeting_location do
      latlon nil
    end

    factory :another_real_place do
      name "Another Real Place"
      address1 "151 Kent Ave"
      address2 nil
      city "Brooklyn"
      state "NY"
      postal_code "11249"
      latlon "POINT (-73.962935 40.718753)"
    end
  end

end
