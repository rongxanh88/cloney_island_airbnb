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

ActiveRecord::Schema.define(version: 20170716172954) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "amenities", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "listing_amenities", force: :cascade do |t|
    t.bigint "amenity_id"
    t.bigint "listing_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["amenity_id"], name: "index_listing_amenities_on_amenity_id"
    t.index ["listing_id"], name: "index_listing_amenities_on_listing_id"
  end

  create_table "listing_images", force: :cascade do |t|
    t.bigint "listing_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "property_image_file_name"
    t.string "property_image_content_type"
    t.integer "property_image_file_size"
    t.datetime "property_image_updated_at"
    t.index ["listing_id"], name: "index_listing_images_on_listing_id"
  end

  create_table "listings", force: :cascade do |t|
    t.text "name"
    t.text "description"
    t.integer "accomodates"
    t.integer "bathrooms"
    t.integer "bedrooms"
    t.integer "beds"
    t.float "price"
    t.text "house_rules"
    t.integer "property_type"
    t.integer "bed_type"
    t.integer "pet_type"
    t.integer "room_type"
    t.bigint "user_id"
    t.integer "status", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "cancellation_policy", default: 0
    t.string "address"
    t.index ["user_id"], name: "index_listings_on_user_id"
  end

  create_table "roles", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "trips", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "host_id"
    t.integer "trip_status", default: 0
    t.date "start_date"
    t.date "end_date"
    t.integer "num_guests"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "listing_id"
    t.index ["host_id"], name: "index_trips_on_host_id"
    t.index ["listing_id"], name: "index_trips_on_listing_id"
    t.index ["user_id"], name: "index_trips_on_user_id"
  end

  create_table "user_roles", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "role_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["role_id"], name: "index_user_roles_on_role_id"
    t.index ["user_id"], name: "index_user_roles_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.date "birthday"
    t.string "first_name"
    t.string "last_name"
    t.string "phone_number"
    t.string "email"
    t.string "password_digest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "profile_picture_file_name"
    t.string "profile_picture_content_type"
    t.integer "profile_picture_file_size"
    t.datetime "profile_picture_updated_at"
    t.string "provider"
    t.string "uid"
    t.string "oauth_token"
    t.datetime "oauth_expires_at"
  end

  add_foreign_key "listing_amenities", "amenities"
  add_foreign_key "listing_amenities", "listings"
  add_foreign_key "listing_images", "listings"
  add_foreign_key "listings", "users"
  add_foreign_key "trips", "listings"
  add_foreign_key "trips", "users"
  add_foreign_key "trips", "users", column: "host_id"
  add_foreign_key "user_roles", "roles"
  add_foreign_key "user_roles", "users"
end
