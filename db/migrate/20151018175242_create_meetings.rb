class CreateMeetings < ActiveRecord::Migration
  def change
    create_table :meetings do |t|
      t.references :meeting_location, index: true, foreign_key: true
      t.references :meeting_group, index: true, foreign_key: true
      t.string :name
      t.time :start_time

      t.timestamps null: false
    end
  end
end
