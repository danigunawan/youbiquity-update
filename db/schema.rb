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

ActiveRecord::Schema.define(version: 20170111182346) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "brands", force: :cascade do |t|
    t.string   "name",       null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_brands_on_name", unique: true, using: :btree
  end

  create_table "categories", force: :cascade do |t|
    t.string   "name",       null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_categories_on_name", unique: true, using: :btree
  end

  create_table "listings", force: :cascade do |t|
    t.integer  "lessor_id",                        null: false
    t.string   "listing_title",                    null: false
    t.text     "detail_desc",                      null: false
    t.string   "location",                         null: false
    t.float    "lat",                              null: false
    t.float    "lng",                              null: false
    t.integer  "day_rate",                         null: false
    t.integer  "replacement_value",                null: false
    t.string   "serial",                           null: false
    t.integer  "brand_id",                         null: false
    t.integer  "category_id",                      null: false
    t.boolean  "active",            default: true, null: false
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
    t.index ["brand_id"], name: "index_listings_on_brand_id", using: :btree
    t.index ["category_id"], name: "index_listings_on_category_id", using: :btree
    t.index ["lat"], name: "index_listings_on_lat", using: :btree
    t.index ["lessor_id"], name: "index_listings_on_lessor_id", using: :btree
    t.index ["lng"], name: "index_listings_on_lng", using: :btree
  end

  create_table "photos", force: :cascade do |t|
    t.integer  "listing_id", null: false
    t.string   "image_url",  null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["listing_id"], name: "index_photos_on_listing_id", using: :btree
  end

  create_table "rentals", force: :cascade do |t|
    t.integer  "listing_id", null: false
    t.integer  "lessee_id",  null: false
    t.date     "start_date", null: false
    t.date     "end_date",   null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["lessee_id"], name: "index_rentals_on_lessee_id", using: :btree
    t.index ["listing_id"], name: "index_rentals_on_listing_id", using: :btree
  end

  create_table "reviews", force: :cascade do |t|
    t.integer  "rental_id",   null: false
    t.integer  "review",      null: false
    t.text     "review_text"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["rental_id"], name: "index_reviews_on_rental_id", unique: true, using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.string   "username",        null: false
    t.string   "password_digest", null: false
    t.string   "session_token",   null: false
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.index ["username"], name: "index_users_on_username", unique: true, using: :btree
  end

end
