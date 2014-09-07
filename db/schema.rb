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

ActiveRecord::Schema.define(version: 20140906192440) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "photos", force: true do |t|
    t.string   "source_url"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "author_name"
    t.string   "author_url"
    t.text     "colors",      default: "--- []\n"
    t.string   "tumblr_url"
  end

  create_table "users", force: true do |t|
    t.string   "name"
    t.string   "access_token"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "access_secret"
    t.boolean  "waitlist",      default: true
    t.string   "email"
    t.string   "dropbox_uid"
    t.text     "completions"
    t.string   "customer_id"
  end

end
