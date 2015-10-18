class Meeting < ActiveRecord::Base
  belongs_to :location, class_name: 'MeetingLocation', foreign_key: 'meeting_location_id'
  belongs_to :group, class_name: 'MeetingGroup', foreign_key: 'meeting_group_id'
  has_and_belongs_to_many :weekdays

  validate :must_have_at_least_one_weekday
  validates :location, presence: true
  validates :name, presence: true
  validates :start_time, presence: true

  accepts_nested_attributes_for :location

  private
  def must_have_at_least_one_weekday
    if weekdays.empty?
      errors.add(:weekdays, "Please choose at least one day of the week")
    end
  end
end
