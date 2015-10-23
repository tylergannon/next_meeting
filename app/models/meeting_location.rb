class MeetingLocation < ActiveRecord::Base
  has_many :meetings
  attr_accessor :result
  validates :name, presence: true
  validates :address1, presence: true
  validates :city, presence: true
  validates :postal_code, presence: true

  def geocoded?
    latitude.present? && longitude.present?
  end

  geocoded_by :full_address do |model, results|
    if model.result = results.first
      result = model.result
      if result.street_number

        model.latlon = "POINT(#{result.longitude} #{result.latitude})"
        model.address1=       result.address
        model.city=          result.city
        model.state=         result.state_code
        model.postal_code=   result.postal_code
      else
        model.errors.add(:latlon, "#{result.address} could not be parsed.")
      end
    end
  end

  def geocode!
    geocode
    save!
  end

  def full_address
    [full_street_address, city, state, postal_code].reject{|t| t.nil?}.join(', ')
  end

  def search_display
    name + " -- " + full_address
  end

  def display_address
    [full_street_address, city, postal_code].reject{|t| t.nil?}.join(', ')
  end

  def full_street_address
    if address2
      address1 + " " + address2
    else
      address1
    end
  end

  def latitude
    self.latlon.lat if latlon
  end

  def longitude
    self.latlon.lon if latlon
  end

  def to_coordinates
    [latitude, longitude]
  end

  def distance_from(latitude, longitude)
    Unit(Geocoder::Calculations.distance_between(self, [latitude, longitude], units: :km), 'km')
  end

  def self.within_distance_from(unit, latitude, longitude)
    within_meters_from(unit.convert_to("m").scalar.to_f, latitude, longitude)
  end

  #  Get distance in meters from location to meeting.
  #  select meetings.*, meeting_locations.*, ST_Distance(ST_GeomFromText('POINT(-73.94510919999999 40.7110184)',4326), latlon)
  #  from meeting_locations inner join meetings on meetings.meeting_location_id = meeting_location.id
  #  where ST_DWithin(ST_GeomFromText('POINT(-73.94510919999999 40.7110184)',4326), latlon, 900)

  def self.within_meters_from(distance_in_meters, latitude, longitude)
    where("earth_box(ll_to_earth(?, ?), ?) @> ll_to_earth(meeting_locations.latitude, meeting_locations.longitude)", latitude, longitude, distance_in_meters)
  end

  def self.in_the_same_place_as(another_location)
    where.not(id: another_location.id).
      where(latlon: another_location.latlon)
  end
end
