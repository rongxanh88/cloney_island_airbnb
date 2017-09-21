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

ActiveRecord::Schema.define(version: 20170920195523) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "amenities", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "conversations", force: :cascade do |t|
    t.bigint "trip_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["trip_id"], name: "index_conversations_on_trip_id"
  end

  create_table "exp_experience_categories", force: :cascade do |t|
    t.bigint "experience_id"
    t.bigint "experience_category_id"
    t.index ["experience_category_id"], name: "index_exp_experience_categories_on_experience_category_id"
    t.index ["experience_id"], name: "index_exp_experience_categories_on_experience_id"
  end

  create_table "experience_categories", force: :cascade do |t|
    t.string "name"
  end

  create_table "experience_images", force: :cascade do |t|
    t.string "image_file_name"
    t.string "image_content_type"
    t.integer "image_file_size"
    t.datetime "image_updated_at"
    t.bigint "experience_id"
    t.index ["experience_id"], name: "index_experience_images_on_experience_id"
  end

  create_table "experiences", force: :cascade do |t|
    t.string "title"
    t.string "duration"
    t.text "tagline"
    t.text "what"
    t.text "where"
    t.text "provisions"
    t.text "notes"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "price"
    t.text "host_description"
    t.integer "group_size"
    t.text "guest_requirements"
    t.string "cancellation_policy_type"
    t.string "street_address"
    t.string "city"
    t.string "state"
    t.string "zipcode"
    t.index ["user_id"], name: "index_experiences_on_user_id"
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
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "airbnb_id"
    t.string "name"
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
    t.integer "status"
    t.text "address"
    t.integer "cancellation_policy", default: 0
    t.index ["user_id"], name: "index_listings_on_user_id"
  end

  create_table "messages", force: :cascade do |t|
    t.bigint "conversation_id"
    t.bigint "user_id"
    t.string "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["conversation_id"], name: "index_messages_on_conversation_id"
    t.index ["user_id"], name: "index_messages_on_user_id"
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
    t.string "verification_code"
  end

  add_foreign_key "conversations", "trips"
  add_foreign_key "exp_experience_categories", "experience_categories"
  add_foreign_key "exp_experience_categories", "experiences"
  add_foreign_key "experience_images", "experiences"
  add_foreign_key "experiences", "users"
  add_foreign_key "listing_amenities", "amenities"
  add_foreign_key "listing_amenities", "listings"
  add_foreign_key "listing_images", "listings"
  add_foreign_key "listings", "users"
  add_foreign_key "messages", "conversations"
  add_foreign_key "messages", "users"
  add_foreign_key "trips", "listings"
  add_foreign_key "trips", "users"
  add_foreign_key "trips", "users", column: "host_id"
  add_foreign_key "user_roles", "roles"
  add_foreign_key "user_roles", "users"
end
