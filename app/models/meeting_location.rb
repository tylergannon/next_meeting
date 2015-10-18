class MeetingLocation < ActiveRecord::Base
  has_many :meetings

  def geocoded?
    latitude.present? && longitude.present?
  end

  def full_address
    [full_street_address, city, state, postal_code].reject{|t| t.nil?}.join(', ')
  end

  def full_street_address
    if address2
      address1 + " " + address2
    else
      address1
    end
  end
end
