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

ActiveRecord::Schema[8.0].define(version: 2025_05_30_090729) do
  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
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

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "custom_fields", force: :cascade do |t|
    t.string "name"
    t.string "value"
    t.integer "login_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["login_id"], name: "index_custom_fields_on_login_id"
  end

  create_table "folders", force: :cascade do |t|
    t.string "name"
    t.integer "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_folders_on_user_id"
  end

  create_table "logins", force: :cascade do |t|
    t.string "name"
    t.string "login_name"
    t.string "login_password"
    t.text "notes"
    t.boolean "is_favorite"
    t.integer "folder_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "file"
    t.date "trash_date"
    t.string "iv"
    t.index ["folder_id"], name: "index_logins_on_folder_id"
  end

  create_table "notes", force: :cascade do |t|
    t.string "text"
    t.string "iv"
    t.integer "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name"
    t.string "name_iv"
    t.index ["user_id"], name: "index_notes_on_user_id"
  end

  create_table "rsas", force: :cascade do |t|
    t.string "public_key"
    t.string "private_key"
    t.string "private_key_iv"
    t.integer "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_rsas_on_user_id"
  end

  create_table "shared_login_data", force: :cascade do |t|
    t.integer "login_id", null: false
    t.integer "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "password"
    t.index ["login_id"], name: "index_shared_login_data_on_login_id"
    t.index ["user_id"], name: "index_shared_login_data_on_user_id"
  end

  create_table "sshkeys", force: :cascade do |t|
    t.string "name"
    t.string "private_key"
    t.string "iv"
    t.string "public_key"
    t.string "notes"
    t.integer "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_sshkeys_on_user_id"
  end

  create_table "urls", force: :cascade do |t|
    t.string "uri"
    t.integer "login_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "fav_icon"
    t.index ["login_id"], name: "index_urls_on_login_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email"
    t.string "name"
    t.string "password_digest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "salt"
    t.string "credential_id"
    t.text "public_key"
    t.integer "sign_count"
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "custom_fields", "logins"
  add_foreign_key "folders", "users"
  add_foreign_key "logins", "folders"
  add_foreign_key "notes", "users"
  add_foreign_key "rsas", "users"
  add_foreign_key "shared_login_data", "logins"
  add_foreign_key "shared_login_data", "users"
  add_foreign_key "sshkeys", "users"
  add_foreign_key "urls", "logins"
end
