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

ActiveRecord::Schema.define(version: 20150208025640) do

  create_table "bookingfinals", force: :cascade do |t|
    t.string   "useremail",  limit: 255
    t.string   "tripid",     limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "driver_trip_routes", force: :cascade do |t|
    t.string   "pointlat",      limit: 255
    t.string   "pointlong",     limit: 255
    t.integer  "DriverTrip_id", limit: 4
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  add_index "driver_trip_routes", ["DriverTrip_id"], name: "index_driver_trip_routes_on_DriverTrip_id", using: :btree

  create_table "driver_trip_seats", force: :cascade do |t|
    t.string   "from",          limit: 255
    t.string   "to",            limit: 255
    t.string   "seatsoccupied", limit: 255
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  create_table "driver_trips", force: :cascade do |t|
    t.string   "start",           limit: 255
    t.string   "end",             limit: 255
    t.string   "isCurrent",       limit: 255
    t.string   "currentPosition", limit: 255
    t.integer  "Driver_id",       limit: 4
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.string   "startlong",       limit: 255
    t.string   "endlong",         limit: 255
    t.string   "currentlong",     limit: 255
  end

  add_index "driver_trips", ["Driver_id"], name: "index_driver_trips_on_Driver_id", using: :btree

  create_table "drivers", force: :cascade do |t|
    t.string   "name",            limit: 255
    t.string   "mobile",          limit: 255
    t.string   "currentlocation", limit: 255
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.string   "long",            limit: 255
  end

  create_table "tests", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.text     "content",    limit: 65535
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  create_table "trip_routes", force: :cascade do |t|
    t.string   "pointlat",      limit: 255
    t.string   "pointlong",     limit: 255
    t.integer  "DriverTrip_id", limit: 4
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "name",        limit: 255
    t.string   "email",       limit: 255
    t.string   "password",    limit: 255
    t.string   "mobile",      limit: 255
    t.string   "source",      limit: 255
    t.string   "device_id",   limit: 255
    t.string   "defaultlat",  limit: 255
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.string   "defaultlong", limit: 255
  end

  add_foreign_key "driver_trips", "Drivers"
end
