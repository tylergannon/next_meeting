# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
#

[Meeting, MeetingGroup, MeetingLocation].each &:delete_all

@location1 = MeetingLocation.create!( name: "Our Lady of Mount Carmel Church",
  address1: "275 North 8th St",
  city: "Brooklyn",
  state: "NY",
  postal_code: "11211",
  notes: "Basement")

@location1.geocode!

group = MeetingGroup.create! name: "Williamsburg Morning Higher Power"
weekdays = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday"].map{|t| Weekday.find_by(name: t)}

  Meeting.create name: group.name,
    group: group,
    location: @location1,
    start_time: "7:15",
    weekdays: weekdays

group = MeetingGroup.create! name: 'Alphabet Soup'

Meeting.create! name: group.name, group: group, location: @location1, start_time: '20:15', weekdays: [Weekday.wednesday]

group = MeetingGroup.create! name: 'Central Awareness'
location = MeetingLocation.create! name: 'St. Barbara’s Church Annex', address1: '144 Bleeker Street', city: 'Brooklyn', state: 'NY', postal_code: '11221'
Meeting.create! name: group.name, location: location, start_time: '10:30', weekdays: [Weekday.saturday]
location.geocode!

group = MeetingGroup.create! name: "Chock Full O' Nuts"
location = MeetingLocation.create! name: 'Cathedral of Joy', address1: '43 George St', city: 'Brooklyn', state: 'NY', postal_code: '11206'
location.geocode!
Meeting.create! name: group.name, location: location, weekdays: [Weekday.thursday], start_time: '20:15'

group = MeetingGroup.create! name: 'High Noon at One'
Meeting.create! name: group.name, location: @location1, weekdays: weekdays, start_time: '13:00'

def meeting(name, days, time)
  Meeting.create! name: name,
  location: @location1, group: MeetingGroup.find_or_create_by(name: name),
  weekdays: days, start_time: time
end

meeting 'Morning Higher Power', weekdays, '07:15'
meeting 'Bleeding Deacons', [Weekday.monday, Weekday.tuesday, Weekday.wednesday, Weekday.thursday], '22:00'
meeting 'Bleeding Deacons', [Weekday.friday, Weekday.saturday], '21:30'
meeting 'Bleeding Deacons', [Weekday.sunday], '17:30'



