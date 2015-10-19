class Meeting < ActiveRecord::Base
  belongs_to :location, class_name: 'MeetingLocation', foreign_key: 'meeting_location_id'
  belongs_to :group, class_name: 'MeetingGroup', foreign_key: 'meeting_group_id'
  has_and_belongs_to_many :weekdays

  validate :must_have_at_least_one_weekday
  validates :location, presence: true
  validates :name, presence: true
  validates :start_time, presence: true

  accepts_nested_attributes_for :location

  def self.find_near(latitude, longitude, distance)
    #  We're running straight SQL here, so be sure to sanitize all inputs to avoid SQL injection.
    latitude = latitude.to_f
    longitude = longitude.to_f
    if distance.is_a?(RubyUnits::Unit)
      distance = distance.convert_to("m").scalar
    end
    puts distance.class.name
    meters = distance.to_f
    point = "ST_GeomFromText('POINT(#{longitude} #{latitude})',4326)"

    joins(:location).includes(:location).
      where("ST_DWithin(#{point}, meeting_locations.latlon, #{meters})").
      order("ST_Distance(#{point}, latlon)")
  end

  def self.by_day_of_week(*day_names)
    joins(:weekdays).where(weekdays: {name: day_names})
  end

  def self.between_times(t1, t2)
    where(start_time: convert_to_time(t1)..convert_to_time(t2))
  end

  def self.starting_after(t)
    between_times(t, '23:59')
  end

  def self.within_time_period(t, time_unit)
    t = convert_to_time(t)
    between_times(t, (t + time_unit.convert_to('minutes').scalar.to_f.minutes))
  end

  private
  def must_have_at_least_one_weekday
    if weekdays.empty?
      errors.add(:weekdays, "Please choose at least one day of the week")
    end
  end

  def self.convert_to_time(t)
    unless t.kind_of?(Time)
      t = Time.parse("2000-01-01 #{t}:00 UTC")
    end
    t
  end
end
