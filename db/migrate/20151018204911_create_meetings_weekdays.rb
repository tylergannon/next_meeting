class CreateMeetingsWeekdays < ActiveRecord::Migration
  def change
    create_table :meetings_weekdays, index: false do |t|
      t.integer :meeting_id
      t.integer :weekday_id
    end
    add_index :meetings_weekdays, :meeting_id
    add_index :meetings_weekdays, :weekday_id
  end
end
