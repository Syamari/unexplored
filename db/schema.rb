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

ActiveRecord::Schema[7.1].define(version: 2024_03_29_182553) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "artist_genres", force: :cascade do |t|
    t.bigint "artist_id", null: false
    t.bigint "genre_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["artist_id"], name: "index_artist_genres_on_artist_id"
    t.index ["genre_id"], name: "index_artist_genres_on_genre_id"
  end

  create_table "artists", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "bookmarks", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "list_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["list_id"], name: "index_bookmarks_on_list_id"
    t.index ["user_id", "list_id"], name: "index_bookmarks_on_user_id_and_list_id", unique: true
    t.index ["user_id"], name: "index_bookmarks_on_user_id"
  end

  create_table "genres", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "list_artists", force: :cascade do |t|
    t.bigint "list_id", null: false
    t.bigint "artist_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["artist_id"], name: "index_list_artists_on_artist_id"
    t.index ["list_id"], name: "index_list_artists_on_list_id"
  end

  create_table "lists", force: :cascade do |t|
    t.string "name"
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "public", default: false
    t.index ["user_id"], name: "index_lists_on_user_id"
  end

  create_table "rates", force: :cascade do |t|
    t.integer "score"
    t.bigint "song_id", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["song_id"], name: "index_rates_on_song_id"
    t.index ["user_id"], name: "index_rates_on_user_id"
  end

  create_table "songs", force: :cascade do |t|
    t.string "name"
    t.bigint "artist_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["artist_id"], name: "index_songs_on_artist_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", null: false
    t.string "crypted_password"
    t.string "salt"
    t.string "user_name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  add_foreign_key "artist_genres", "artists"
  add_foreign_key "artist_genres", "genres"
  add_foreign_key "bookmarks", "lists"
  add_foreign_key "bookmarks", "users"
  add_foreign_key "list_artists", "artists"
  add_foreign_key "list_artists", "lists"
  add_foreign_key "lists", "users"
  add_foreign_key "rates", "songs"
  add_foreign_key "rates", "users"
  add_foreign_key "songs", "artists"
end
