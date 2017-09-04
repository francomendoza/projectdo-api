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

ActiveRecord::Schema.define(version: 20170903172855) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "categories", force: :cascade do |t|
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "mission_categories", force: :cascade do |t|
    t.bigint "mission_id"
    t.bigint "category_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["category_id"], name: "index_mission_categories_on_category_id"
    t.index ["mission_id"], name: "index_mission_categories_on_mission_id"
  end

  create_table "mission_due_dates", force: :cascade do |t|
    t.datetime "due_date"
    t.string "option"
    t.bigint "mission_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["mission_id"], name: "index_mission_due_dates_on_mission_id"
  end

  create_table "mission_statuses", force: :cascade do |t|
    t.string "description"
    t.bigint "mission_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["mission_id"], name: "index_mission_statuses_on_mission_id"
  end

  create_table "missions", force: :cascade do |t|
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "mission_categories", "categories"
  add_foreign_key "mission_categories", "missions"
  add_foreign_key "mission_due_dates", "missions"
  add_foreign_key "mission_statuses", "missions"
end
