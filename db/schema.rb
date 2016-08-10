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

ActiveRecord::Schema.define(version: 20160809214031) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "instagram_posts", force: :cascade do |t|
    t.json     "data"
    t.bigint   "managed_instagram_account_id"
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.string   "instagram_id"
    t.index ["instagram_id"], name: "index_instagram_posts_on_instagram_id", unique: true, using: :btree
    t.index ["managed_instagram_account_id"], name: "index_instagram_posts_on_managed_instagram_account_id", using: :btree
  end

  create_table "managed_instagram_accounts", id: :bigserial, force: :cascade do |t|
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

  create_table "news_items", force: :cascade do |t|
    t.string   "title"
    t.string   "subtitle"
    t.text     "body"
    t.datetime "created_at",                           null: false
    t.datetime "updated_at",                           null: false
    t.string   "photo_file_name"
    t.string   "photo_content_type"
    t.integer  "photo_file_size"
    t.datetime "photo_updated_at"
    t.string   "straphead"
    t.string   "photo_caption"
    t.string   "state",              default: "draft"
  end

  create_table "play_event_images", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.string   "file_file_name"
    t.string   "file_content_type"
    t.integer  "file_file_size"
    t.datetime "file_updated_at"
    t.index ["name"], name: "index_play_event_images_on_name", unique: true, using: :btree
  end

  create_table "play_events", force: :cascade do |t|
    t.string   "title"
    t.string   "artist"
    t.string   "album"
    t.integer  "length_in_secs"
    t.string   "type"
    t.integer  "station_id"
    t.integer  "nexgen_id"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
    t.integer  "play_event_image_id"
    t.index ["play_event_image_id"], name: "index_play_events_on_play_event_image_id", using: :btree
    t.index ["station_id"], name: "index_play_events_on_station_id", using: :btree
  end

  create_table "programs", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text     "schedule"
    t.integer  "station_id"
    t.index ["station_id"], name: "index_programs_on_station_id", using: :btree
  end

  create_table "roles", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "roles_users", id: false, force: :cascade do |t|
    t.integer "role_id", null: false
    t.integer "user_id", null: false
    t.index ["role_id", "user_id"], name: "by_user_and_role", unique: true, using: :btree
    t.index ["role_id", "user_id"], name: "index_roles_users_on_role_id_and_user_id", using: :btree
    t.index ["user_id", "role_id"], name: "index_roles_users_on_user_id_and_role_id", using: :btree
  end

  create_table "stations", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "tag"
    t.index ["name"], name: "index_stations_on_name", unique: true, using: :btree
    t.index ["tag"], name: "index_stations_on_tag", unique: true, using: :btree
  end

  create_table "stream_metrics", force: :cascade do |t|
    t.string   "name"
    t.integer  "connection_count"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.index ["created_at"], name: "index_stream_metrics_on_created_at", using: :btree
    t.index ["name"], name: "index_stream_metrics_on_name", using: :btree
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
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.string   "full_name"
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true, using: :btree
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
    t.index ["unlock_token"], name: "index_users_on_unlock_token", unique: true, using: :btree
  end

  add_foreign_key "instagram_posts", "managed_instagram_accounts"
  add_foreign_key "play_events", "play_event_images"
  add_foreign_key "play_events", "stations"
  add_foreign_key "programs", "stations"
  add_foreign_key "tweets", "managed_twitter_accounts"
end
