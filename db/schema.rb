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

ActiveRecord::Schema.define(version: 20151119030549) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "cities", force: :cascade do |t|
    t.string   "name"
    t.string   "image_path"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "slug"
    t.string   "short_d"
    t.string   "long_d"
  end

  create_table "order_trips", force: :cascade do |t|
    t.integer "quantity"
    t.integer "trip_id"
    t.integer "order_id"
    t.integer "subtotal"
  end

  add_index "order_trips", ["order_id"], name: "index_order_trips_on_order_id", using: :btree
  add_index "order_trips", ["trip_id"], name: "index_order_trips_on_trip_id", using: :btree

  create_table "orders", force: :cascade do |t|
    t.integer "user_id"
    t.integer "total"
    t.string  "status_timestamp"
    t.integer "status"
  end

  add_index "orders", ["user_id"], name: "index_orders_on_user_id", using: :btree

  create_table "trips", force: :cascade do |t|
    t.string   "name"
    t.integer  "city_id"
    t.integer  "price"
    t.string   "description"
    t.string   "image_path"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.string   "slug"
    t.text     "info"
    t.integer  "status"
  end

  add_index "trips", ["city_id"], name: "index_trips_on_city_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "username"
    t.string   "password_digest"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.integer  "role"
    t.string   "address"
    t.string   "city"
    t.string   "state"
    t.integer  "zip"
    t.string   "first_name"
    t.string   "last_name"
  end

  add_foreign_key "order_trips", "orders"
  add_foreign_key "order_trips", "trips"
  add_foreign_key "orders", "users"
  add_foreign_key "trips", "cities"
end
