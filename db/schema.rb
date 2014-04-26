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

ActiveRecord::Schema.define(version: 20140426103525) do

  create_table "batter_stats", force: true do |t|
    t.integer  "batter_id",  null: false
    t.integer  "h",          null: false
    t.integer  "ab",         null: false
    t.integer  "tb",         null: false
    t.integer  "r",          null: false
    t.integer  "b2",         null: false
    t.integer  "b3",         null: false
    t.integer  "hr",         null: false
    t.integer  "rbi",        null: false
    t.integer  "sac",        null: false
    t.integer  "sf",         null: false
    t.integer  "hbp",        null: false
    t.integer  "bb",         null: false
    t.integer  "ibb",        null: false
    t.integer  "so",         null: false
    t.integer  "sb",         null: false
    t.integer  "cs",         null: false
    t.integer  "gidp",       null: false
    t.integer  "np",         null: false
    t.integer  "go",         null: false
    t.integer  "ao",         null: false
    t.integer  "tpa",        null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "batter_stats", ["batter_id"], name: "index_batter_stats_on_batter_id", unique: true, using: :btree

  create_table "batters", force: true do |t|
    t.integer  "player_id",  null: false
    t.integer  "h",          null: false
    t.integer  "ab",         null: false
    t.integer  "tb",         null: false
    t.integer  "r",          null: false
    t.integer  "b2",         null: false
    t.integer  "b3",         null: false
    t.integer  "hr",         null: false
    t.integer  "rbi",        null: false
    t.integer  "sac",        null: false
    t.integer  "sf",         null: false
    t.integer  "hbp",        null: false
    t.integer  "bb",         null: false
    t.integer  "ibb",        null: false
    t.integer  "so",         null: false
    t.integer  "sb",         null: false
    t.integer  "cs",         null: false
    t.integer  "gidp",       null: false
    t.integer  "np",         null: false
    t.integer  "go",         null: false
    t.integer  "ao",         null: false
    t.integer  "tpa",        null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "batters", ["player_id"], name: "index_batters_on_player_id", unique: true, using: :btree

  create_table "players", id: false, force: true do |t|
    t.integer  "id",                      null: false
    t.string   "first_name",              null: false
    t.string   "last_name",               null: false
    t.integer  "bats",          limit: 1, null: false
    t.integer  "throws",        limit: 1, null: false
    t.integer  "pos",           limit: 1, null: false
    t.integer  "jersey_number",           null: false
    t.integer  "team_id",                 null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "players", ["id"], name: "index_players_on_id", unique: true, using: :btree
  add_index "players", ["team_id"], name: "index_players_on_team_id", using: :btree

  create_table "teams", id: false, force: true do |t|
    t.integer  "id",         null: false
    t.integer  "league_id",  null: false
    t.string   "name",       null: false
    t.string   "abbrev",     null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "teams", ["id"], name: "index_teams_on_id", unique: true, using: :btree

end
