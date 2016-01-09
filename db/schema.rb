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

ActiveRecord::Schema.define(version: 20160109011434) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "pg_trgm"

  create_table "addresses", force: :cascade do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "street"
    t.string   "city"
    t.string   "state"
    t.string   "zipcode"
    t.string   "country"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "addresses", ["user_id"], name: "index_addresses_on_user_id", using: :btree

  create_table "carts", force: :cascade do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "payment_info_id"
    t.integer  "order_contact_info_id"
    t.integer  "address_id"
    t.boolean  "ready_to_purchase",     default: false
  end

  create_table "delivery_options", force: :cascade do |t|
    t.string   "option_type",  null: false
    t.string   "license"
    t.string   "nationality"
    t.integer  "quantity"
    t.string   "border"
    t.integer  "line_item_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "delivery_options", ["line_item_id"], name: "index_delivery_options_on_line_item_id", using: :btree

  create_table "events", force: :cascade do |t|
    t.string  "title"
    t.string  "description"
    t.string  "location"
    t.string  "photographer"
    t.date    "date"
    t.string  "sub_title"
    t.string  "slug"
    t.string  "image_url_id"
    t.boolean "is_featured"
    t.string  "password"
  end

  create_table "friendly_id_slugs", force: :cascade do |t|
    t.string   "slug",                      null: false
    t.integer  "sluggable_id",              null: false
    t.string   "sluggable_type", limit: 50
    t.string   "scope"
    t.datetime "created_at"
  end

  add_index "friendly_id_slugs", ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true, using: :btree
  add_index "friendly_id_slugs", ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type", using: :btree
  add_index "friendly_id_slugs", ["sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_id", using: :btree
  add_index "friendly_id_slugs", ["sluggable_type"], name: "index_friendly_id_slugs_on_sluggable_type", using: :btree

  create_table "lightbox_photos", force: :cascade do |t|
    t.integer  "lightbox_id"
    t.integer  "photo_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "lightbox_photos", ["lightbox_id"], name: "index_lightbox_photos_on_lightbox_id", using: :btree
  add_index "lightbox_photos", ["photo_id"], name: "index_lightbox_photos_on_photo_id", using: :btree

  create_table "lightboxes", force: :cascade do |t|
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "name"
  end

  add_index "lightboxes", ["user_id"], name: "index_lightboxes_on_user_id", using: :btree

  create_table "line_items", force: :cascade do |t|
    t.integer  "cart_id"
    t.integer  "photo_id"
    t.integer  "order_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "order_contact_infos", force: :cascade do |t|
    t.string   "email",      null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "order_shipping_infos", force: :cascade do |t|
    t.string   "first_name", null: false
    t.string   "last_name",  null: false
    t.string   "city",       null: false
    t.string   "country",    null: false
    t.string   "state",      null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "street"
    t.string   "zipcode"
  end

  create_table "orders", force: :cascade do |t|
    t.integer  "order_shipping_info_id", null: false
    t.integer  "order_contact_info_id",  null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.string   "stripe_charge_id"
    t.integer  "payment_info_id"
  end

  create_table "payment_infos", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "brand",              null: false
    t.integer  "exp_month",          null: false
    t.integer  "exp_year",           null: false
    t.string   "last4",              null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "stripe_customer_id"
  end

  create_table "photos", force: :cascade do |t|
    t.string   "file_id"
    t.string   "copyright"
    t.integer  "event_id"
    t.string   "size"
    t.string   "slug"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "personal_price"
    t.integer  "commercial_price"
  end

  create_table "settings", force: :cascade do |t|
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
    t.integer  "personal_price",      null: false
    t.integer  "commercial_price",    null: false
    t.integer  "personal_image_size", null: false
  end

  create_table "taggings", force: :cascade do |t|
    t.integer  "tag_id"
    t.integer  "taggable_id"
    t.string   "taggable_type"
    t.integer  "tagger_id"
    t.string   "tagger_type"
    t.string   "context",       limit: 128
    t.datetime "created_at"
  end

  add_index "taggings", ["tag_id", "taggable_id", "taggable_type", "context", "tagger_id", "tagger_type"], name: "taggings_idx", unique: true, using: :btree
  add_index "taggings", ["taggable_id", "taggable_type", "context"], name: "index_taggings_on_taggable_id_and_taggable_type_and_context", using: :btree

  create_table "tags", force: :cascade do |t|
    t.string  "name"
    t.integer "taggings_count", default: 0
  end

  add_index "tags", ["name"], name: "index_tags_on_name", unique: true, using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "",    null: false
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "first_name"
    t.string   "last_name"
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.boolean  "is_admin",               default: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  create_table "vip_at_events", force: :cascade do |t|
    t.integer "vip_id"
    t.integer "event_id"
  end

  create_table "vip_at_photos", force: :cascade do |t|
    t.integer "vip_id"
    t.integer "photo_id"
  end

  create_table "vips", force: :cascade do |t|
    t.string "name"
  end

  add_foreign_key "lightbox_photos", "lightboxes"
  add_foreign_key "lightbox_photos", "photos"
  add_foreign_key "lightboxes", "users"
end
