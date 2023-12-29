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

ActiveRecord::Schema[7.0].define(version: 2023_12_29_133310) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "competitions", force: :cascade do |t|
    t.bigint "league_id", null: false
    t.bigint "season_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["league_id"], name: "index_competitions_on_league_id"
    t.index ["season_id"], name: "index_competitions_on_season_id"
  end

  create_table "fixtures", force: :cascade do |t|
    t.bigint "hometeam_id", null: false
    t.bigint "awayteam_id", null: false
    t.datetime "dateandtime", precision: nil
    t.integer "scorehome"
    t.integer "scoreaway"
    t.boolean "finished"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "competition_id"
    t.string "round"
    t.index ["awayteam_id"], name: "index_fixtures_on_awayteam_id"
    t.index ["competition_id"], name: "index_fixtures_on_competition_id"
    t.index ["hometeam_id"], name: "index_fixtures_on_hometeam_id"
  end

  create_table "leagues", force: :cascade do |t|
    t.string "name"
    t.string "desc"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "seasons", force: :cascade do |t|
    t.string "startyear"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "standings", force: :cascade do |t|
    t.bigint "competition_id", null: false
    t.integer "round"
    t.bigint "team_id", null: false
    t.integer "rank"
    t.integer "points"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "played"
    t.index ["competition_id"], name: "index_standings_on_competition_id"
    t.index ["team_id"], name: "index_standings_on_team_id"
  end

  create_table "teams", force: :cascade do |t|
    t.string "name"
    t.string "shortname"
    t.string "city"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "competitions", "leagues"
  add_foreign_key "competitions", "seasons"
  add_foreign_key "fixtures", "competitions"
  add_foreign_key "fixtures", "teams", column: "awayteam_id"
  add_foreign_key "fixtures", "teams", column: "hometeam_id"
  add_foreign_key "standings", "competitions"
  add_foreign_key "standings", "teams"
end
