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

ActiveRecord::Schema.define(version: 2022_12_20_081418) do

  create_table "foods", charset: "utf8mb4", force: :cascade do |t|
    t.string "food_name", null: false
    t.integer "calorie", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "price", null: false
    t.index ["user_id"], name: "index_foods_on_user_id"
  end

  create_table "groups", charset: "utf8mb4", force: :cascade do |t|
    t.string "group_name", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_groups_on_user_id"
  end

  create_table "select_foods", charset: "utf8mb4", force: :cascade do |t|
    t.bigint "food_id", null: false
    t.bigint "group_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["food_id", "group_id"], name: "index_select_foods_on_food_id_and_group_id", unique: true
    t.index ["food_id"], name: "index_select_foods_on_food_id"
    t.index ["group_id"], name: "index_select_foods_on_group_id"
  end

  create_table "users", charset: "utf8mb4", force: :cascade do |t|
    t.string "email", null: false
    t.string "crypted_password"
    t.string "salt"
    t.string "name", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  add_foreign_key "foods", "users"
  add_foreign_key "groups", "users"
  add_foreign_key "select_foods", "foods"
  add_foreign_key "select_foods", "groups"
end
