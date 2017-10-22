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

ActiveRecord::Schema.define(version: 20171022103644) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "accounts", force: :cascade do |t|
    t.string   "name"
    t.integer  "yr"
    t.string   "course"
    t.text     "writeup"
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.string   "school"
    t.integer  "student_id"
    t.integer  "timeslot_id"
    t.integer  "groupshot_id"
    t.boolean  "rescheduled"
    t.string   "minor"
    t.string   "cellphone_number"
    t.string   "double_major"
    t.string   "full_course"
    t.boolean  "final_writeup"
    t.string   "second_status"
    t.text     "old_feedback"
    t.text     "feedback"
    t.string   "username"
    t.boolean  "is_graduating"
    t.boolean  "updated_password"
    t.string   "description"
  end

  add_index "accounts", ["email"], name: "index_accounts_on_email", unique: true, using: :btree
  add_index "accounts", ["reset_password_token"], name: "index_accounts_on_reset_password_token", unique: true, using: :btree
  add_index "accounts", ["student_id"], name: "index_accounts_on_student_id", using: :btree
  add_index "accounts", ["timeslot_id"], name: "index_accounts_on_timeslot_id", using: :btree

  create_table "admins", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

  add_index "admins", ["email"], name: "index_admins_on_email", unique: true, using: :btree
  add_index "admins", ["reset_password_token"], name: "index_admins_on_reset_password_token", unique: true, using: :btree

  create_table "contacts", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "course_pages", force: :cascade do |t|
    t.string  "course"
    t.integer "page_number"
  end

  create_table "events", force: :cascade do |t|
    t.string   "title"
    t.text     "description"
    t.date     "start_time"
    t.date     "end_time"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "groupslots", force: :cascade do |t|
    t.integer "groupshot_id", null: false
    t.integer "student_id",   null: false
    t.string  "group_name",   null: false
    t.string  "group_type"
  end

  add_index "groupslots", ["groupshot_id"], name: "index_groupslots_on_groupshot_id", using: :btree
  add_index "groupslots", ["student_id"], name: "index_groupslots_on_student_id", using: :btree

  create_table "students", force: :cascade do |t|
    t.string  "name"
    t.integer "yr"
    t.string  "course"
    t.string  "school"
    t.boolean "account"
    t.integer "page_number"
  end

  create_table "timeslots", force: :cascade do |t|
    t.text    "start_time"
    t.text    "end_time"
    t.date    "date"
    t.integer "slots"
    t.string  "type"
  end

  create_table "writeup_accounts", force: :cascade do |t|
    t.integer "idnumber"
  end

  add_foreign_key "accounts", "timeslots"
end
