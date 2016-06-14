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

ActiveRecord::Schema.define(version: 20160614012213) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "instagram_posts", force: :cascade do |t|
    t.json     "data"
    t.integer  "managed_instagram_account_id"
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.string   "instagram_id"
    t.index ["managed_instagram_account_id"], name: "index_instagram_posts_on_managed_instagram_account_id", using: :btree
  end

  create_table "managed_instagram_accounts", force: :cascade do |t|
    t.string   "username"
    t.string   "token"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean  "published"
  end

  create_table "managed_twitter_accounts", force: :cascade do |t|
    t.string   "username"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean  "published"
    t.index ["username"], name: "index_managed_twitter_accounts_on_username", unique: true, using: :btree
  end

  create_table "news_feed_items", force: :cascade do |t|
    t.integer  "subject_id",   null: false
    t.string   "subject_type", null: false
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.index ["subject_id"], name: "index_news_feed_items_on_subject_id", using: :btree
    t.index ["subject_type"], name: "index_news_feed_items_on_subject_type", using: :btree
  end

  create_table "programs", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text     "schedule"
    t.integer  "station_id"
    t.index ["station_id"], name: "index_programs_on_station_id", using: :btree
  end

  create_table "stations", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_stations_on_name", unique: true, using: :btree
  end

  create_table "tweets", force: :cascade do |t|
    t.integer  "managed_twitter_account_id"
    t.bigint   "twitter_id"
    t.string   "embed"
    t.json     "data"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.index ["managed_twitter_account_id"], name: "index_tweets_on_managed_twitter_account_id", using: :btree
    t.index ["twitter_id"], name: "index_tweets_on_twitter_id", unique: true, using: :btree
  end

  create_table "users", force: :cascade do |t|
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
    t.integer  "failed_attempts",        default: 0,  null: false
    t.string   "unlock_token"
    t.datetime "locked_at"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
    t.index ["unlock_token"], name: "index_users_on_unlock_token", unique: true, using: :btree
  end

  add_foreign_key "instagram_posts", "managed_instagram_accounts"
  add_foreign_key "programs", "stations"
  add_foreign_key "tweets", "managed_twitter_accounts"
end
