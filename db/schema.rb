# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2024_11_28_064040) do
  create_table "active_storage_attachments", charset: "utf8mb3", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", charset: "utf8mb3", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", charset: "utf8mb3", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "child_packing_items", charset: "utf8mb3", force: :cascade do |t|
    t.bigint "trip_id", null: false
    t.string "name", null: false
    t.integer "quantity", default: 1
    t.boolean "is_event_completed", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["trip_id"], name: "index_child_packing_items_on_trip_id"
  end

  create_table "prefectures", charset: "utf8mb3", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_prefectures_on_name", unique: true
  end

  create_table "trip_prefectures", charset: "utf8mb3", force: :cascade do |t|
    t.bigint "trip_id", null: false
    t.bigint "prefecture_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["prefecture_id"], name: "index_trip_prefectures_on_prefecture_id"
    t.index ["trip_id"], name: "index_trip_prefectures_on_trip_id"
  end

  create_table "trips", charset: "utf8mb3", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.integer "budget_total", default: 0
    t.date "start_date"
    t.date "end_date"
    t.text "notes"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_trips_on_user_id"
  end

  create_table "users", charset: "utf8mb3", force: :cascade do |t|
    t.string "name", null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "child_packing_items", "trips"
  add_foreign_key "trip_prefectures", "prefectures"
  add_foreign_key "trip_prefectures", "trips"
  add_foreign_key "trips", "users"
end
