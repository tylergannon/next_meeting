# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
#

location1 = MeetingLocation.create!( name: "Our Lady of Mount Carmel Church",
  address1: "275 North 8th St",
  city: "Brooklyn",
  state: "NY",
  postal_code: "11211",
  notes: "Basement")

location1.geocode!

group = MeetingGroup.create! name: "Williamsburg Morning Higher Power"

days = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday"].map{|t| Weekday.find_by(name: t)}

  Meeting.create name: group.name,
    group: group,
    location: location1,
    start_time: "7:15",
    weekdays: days
