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

ActiveRecord::Schema.define(version: 20160104024828) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "comments", force: :cascade do |t|
    t.text     "body",             null: false
    t.integer  "author_id",        null: false
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.string   "commentable_type"
    t.integer  "commentable_id"
  end

  add_index "comments", ["commentable_id", "commentable_type"], name: "index_comments_on_commentable_id_and_commentable_type", using: :btree

  create_table "delayed_jobs", force: :cascade do |t|
    t.integer  "priority",   default: 0, null: false
    t.integer  "attempts",   default: 0, null: false
    t.text     "handler",                null: false
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.string   "queue"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "delayed_jobs", ["priority", "run_at"], name: "delayed_jobs_priority", using: :btree

  create_table "friendings", force: :cascade do |t|
    t.integer  "friender_id"
    t.integer  "friend_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "friendings", ["friender_id", "friend_id"], name: "index_friendings_on_friender_id_and_friend_id", unique: true, using: :btree

  create_table "likes", force: :cascade do |t|
    t.integer  "creator_id",    null: false
    t.integer  "likeable_id",   null: false
    t.string   "likeable_type", null: false
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  add_index "likes", ["creator_id", "likeable_id", "likeable_type"], name: "index_likes_on_creator_id_and_likeable_id_and_likeable_type", unique: true, using: :btree
  add_index "likes", ["likeable_type", "likeable_id"], name: "index_likes_on_likeable_type_and_likeable_id", using: :btree

  create_table "photos", force: :cascade do |t|
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.integer  "author_id",          null: false
    t.boolean  "image_processing"
  end

  add_index "photos", ["author_id"], name: "index_photos_on_author_id", using: :btree

  create_table "posts", force: :cascade do |t|
    t.text     "body",       null: false
    t.integer  "user_id",    null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "profiles", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "first_name",       null: false
    t.string   "last_name",        null: false
    t.datetime "birthday",         null: false
    t.string   "gender"
    t.text     "about"
    t.text     "quote"
    t.string   "college"
    t.string   "hometown"
    t.string   "current_location"
    t.string   "phone"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.integer  "profile_photo_id"
    t.integer  "cover_photo_id"
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",           null: false
    t.string   "password_digest", null: false
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.string   "auth_token"
  end

  add_index "users", ["auth_token"], name: "index_users_on_auth_token", unique: true, using: :btree
  add_index "users", ["email"], name: "index_users_on_email", using: :btree

end
