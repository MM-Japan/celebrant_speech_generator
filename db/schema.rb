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

ActiveRecord::Schema[7.1].define(version: 2024_11_28_062516) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "speech_requests", force: :cascade do |t|
    t.string "name"
    t.string "relation"
    t.text "memories"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "generated_speech"
    t.text "childhood_overview"
    t.text "work_overview"
    t.text "family_overview"
    t.text "hobbies_overview"
    t.text "travel_overview"
    t.integer "age"
    t.text "follow_up_questions"
    t.text "detailed_answers"
    t.integer "tokens", default: 1000
    t.bigint "user_id", null: false
    t.index ["user_id"], name: "index_speech_requests_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "speech_requests", "users"
end
