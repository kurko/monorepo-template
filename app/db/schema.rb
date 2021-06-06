# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_11_24_022934) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "games", force: :cascade do |t|
    t.bigint "site_id"
    t.text "external_id"
    t.text "event"
    t.text "round"
    t.text "eco"
    t.text "eco_url"
    t.text "time_control"
    t.integer "white_profile_id", null: false
    t.integer "black_profile_id", null: false
    t.integer "white_elo"
    t.integer "black_elo"
    t.decimal "white_result", precision: 2, scale: 1
    t.decimal "black_result", precision: 2, scale: 1
    t.text "termination_description"
    t.boolean "rated"
    t.datetime "started_at"
    t.datetime "finished_at"
    t.text "pgn"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["site_id", "external_id"], name: "index_games_on_site_id_and_external_id", unique: true
    t.index ["site_id"], name: "index_games_on_site_id"
  end

  create_table "profiles", force: :cascade do |t|
    t.bigint "site_id"
    t.text "username"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["site_id", "username"], name: "index_profiles_on_site_id_and_username", unique: true
    t.index ["site_id"], name: "index_profiles_on_site_id"
  end

  create_table "sites", force: :cascade do |t|
    t.text "name", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["name"], name: "index_sites_on_name", unique: true
  end

  add_foreign_key "games", "profiles", column: "black_profile_id"
  add_foreign_key "games", "profiles", column: "white_profile_id"
end
