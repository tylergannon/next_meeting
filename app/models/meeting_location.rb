class MeetingLocation < ActiveRecord::Base
  has_many :meetings

  def geocoded?
    latitude.present? && longitude.present?
  end

  geocoded_by :full_address

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

  def self.in_the_same_place_as(another_location)
    where.not(id: another_location.id).
      where(latitude: another_location.latitude, longitude: another_location.longitude)
  end
end
