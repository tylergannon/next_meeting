class CreateMeetingGroups < ActiveRecord::Migration
  def change
    create_table :meeting_groups do |t|
      t.string :name

      t.timestamps null: false
    end
  end
end
