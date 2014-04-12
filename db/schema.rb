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

ActiveRecord::Schema.define(version: 20140412102304) do

  create_table "batters", id: false, force: true do |t|
    t.integer  "id",                      null: false
    t.string   "first_name",              null: false
    t.string   "last_name",               null: false
    t.integer  "bats",          limit: 1, null: false
    t.integer  "pos",           limit: 1, null: false
    t.integer  "jersey_number",           null: false
    t.integer  "team_id",                 null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "batters", ["id"], name: "index_batters_on_id", unique: true, using: :btree
  add_index "batters", ["team_id"], name: "index_batters_on_team_id", using: :btree

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
