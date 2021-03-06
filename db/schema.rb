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

ActiveRecord::Schema.define(version: 2018_04_20_033018) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "books", force: :cascade do |t|
    t.string "title"
    t.string "author"
    t.string "genre"
    t.string "subgenre"
    t.integer "pages"
    t.string "publisher"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "branches", force: :cascade do |t|
    t.string "name"
    t.string "address"
    t.string "phone_number"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "checkouts", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "copy_id"
    t.datetime "checked_out_at"
    t.datetime "due_at"
    t.datetime "checked_in_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["copy_id"], name: "index_checkouts_on_copy_id"
    t.index ["user_id"], name: "index_checkouts_on_user_id"
  end

  create_table "copies", force: :cascade do |t|
    t.bigint "book_id"
    t.datetime "destroyed_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "branch_id"
    t.bigint "checked_out_by_id"
    t.datetime "checked_out_at"
    t.datetime "due_at"
    t.index ["book_id"], name: "index_copies_on_book_id"
    t.index ["branch_id"], name: "index_copies_on_branch_id"
    t.index ["checked_out_by_id"], name: "index_copies_on_checked_out_by_id"
  end

  create_table "notification_requests", force: :cascade do |t|
    t.bigint "book_id"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["book_id", "user_id"], name: "index_notification_requests_on_book_id_and_user_id", unique: true
    t.index ["book_id"], name: "index_notification_requests_on_book_id"
    t.index ["user_id"], name: "index_notification_requests_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "is_admin", default: false
    t.string "time_zone", default: "Eastern Time (US & Canada)"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "copies", "books"
  add_foreign_key "copies", "branches"
  add_foreign_key "copies", "users", column: "checked_out_by_id"
  add_foreign_key "notification_requests", "books"
  add_foreign_key "notification_requests", "users"
end
