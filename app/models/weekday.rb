class Weekday < ActiveRecord::Base
  has_and_belongs_to_many :meetings

  %w(Sunday Monday Tuesday Wednesday Thursday Friday Saturday).each do |day|
    class_eval "
    def self.#{day.downcase}
      Rails.cache.fetch('#{day.downcase}') do
        find_by(name: '#{day}')
      end
    end
    "
  end

  class << self
    def human_readable_list
      days = order(:id).to_a.map(&:name).map(&:pluralize)
      if days.count == 5 && !days.select{|t| ['Saturdays', 'Sundays'].include? t}.any?
        return 'Weekdays'
      end
      case days.size
      when 7 then 'Everyday'
      when 0 then ''
      when 1 then days.first
      when 2 then days.join(' and ')
      else days[0..-2].join(', ') + ', and ' + days[-1]
      end
    end
  end
end
