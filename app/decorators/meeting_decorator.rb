class MeetingDecorator < Draper::Decorator
  delegate_all

  def formatted_start_time
    object.start_time.strftime("%l:%M")
  end

  def formatted_days
    object.weekdays.human_readable_list
  end


end
