# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20151018204911) do

  create_table "meeting_groups", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "meeting_locations", force: :cascade do |t|
    t.string   "name"
    t.string   "address1"
    t.string   "address2"
    t.string   "city"
    t.string   "state"
    t.string   "postal_code"
    t.float    "latitude"
    t.float    "longitude"
    t.string   "notes"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "meetings", force: :cascade do |t|
    t.integer  "meeting_location_id"
    t.integer  "meeting_group_id"
    t.string   "name"
    t.time     "start_time"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
  end

  add_index "meetings", ["meeting_group_id"], name: "index_meetings_on_meeting_group_id"
  add_index "meetings", ["meeting_location_id"], name: "index_meetings_on_meeting_location_id"

  create_table "meetings_weekdays", force: :cascade do |t|
    t.integer "meeting_id"
    t.integer "weekday_id"
  end

  add_index "meetings_weekdays", ["meeting_id"], name: "index_meetings_weekdays_on_meeting_id"
  add_index "meetings_weekdays", ["weekday_id"], name: "index_meetings_weekdays_on_weekday_id"

  create_table "weekdays", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
