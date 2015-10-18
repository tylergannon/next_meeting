class CreateWeekdays < ActiveRecord::Migration
  def change
    create_table :weekdays do |t|
      t.string :name

      t.timestamps null: false
    end

    Weekday.create name: 'Sunday'
    Weekday.create name: 'Monday'
    Weekday.create name: 'Tuesday'
    Weekday.create name: 'Wednesday'
    Weekday.create name: 'Thursday'
    Weekday.create name: 'Friday'
    Weekday.create name: 'Saturday'
  end
end
