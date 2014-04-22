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

ActiveRecord::Schema.define(version: 20140422180127) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "patterns", force: true do |t|
    t.string   "name"
    t.integer  "designer_id"
    t.string   "category"
    t.string   "yarn_name"
    t.string   "yarn_weight"
    t.integer  "stitch_col"
    t.integer  "stitch_row"
    t.integer  "swatch"
    t.string   "swatch_stitch"
    t.string   "needles"
    t.string   "amount_yarn"
    t.string   "sizes"
    t.string   "price"
    t.text     "notes"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "patterns", ["category"], name: "index_patterns_on_category", using: :btree
  add_index "patterns", ["designer_id"], name: "index_patterns_on_designer_id", using: :btree
  add_index "patterns", ["name"], name: "index_patterns_on_name", using: :btree

  create_table "users", force: true do |t|
    t.string   "password_digest",  null: false
    t.string   "email",            null: false
    t.string   "session_token",    null: false
    t.boolean  "activate"
    t.string   "activation_token"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["session_token"], name: "index_users_on_session_token", unique: true, using: :btree

end
