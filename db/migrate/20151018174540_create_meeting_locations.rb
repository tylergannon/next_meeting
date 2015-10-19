class CreateMeetingLocations < ActiveRecord::Migration
  def change
    create_table :meeting_locations do |t|
      t.string :name
      t.string :address1
      t.string :address2
      t.string :city
      t.string :state
      t.string :postal_code
      t.st_point :latlon, geographic: true
      t.float :latitude
      t.float :longitude
      t.string :notes

      t.timestamps null: false
      t.index :latlon, using: :gist
    end
  end
end
