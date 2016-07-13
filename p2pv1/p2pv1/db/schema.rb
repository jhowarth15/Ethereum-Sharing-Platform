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

ActiveRecord::Schema.define(version: 20160223171106) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "contracts_history", primary_key: "contract_id", force: :cascade do |t|
    t.date   "created_at",            null: false
    t.string "key",        limit: 50, null: false
    t.date   "returned"
  end

  create_table "interest_history", primary_key: "key", force: :cascade do |t|
    t.string "item_id",                  limit: 25, null: false
    t.string "lender_id",                limit: 50, null: false
    t.string "inquirer_id",              limit: 50, null: false
    t.float  "deposit",                             null: false
    t.float  "rental_rate",                         null: false
    t.date   "date_interest_registered",            null: false
    t.date   "loan_start_date",                     null: false
    t.date   "loan_end_date",                       null: false
    t.string "meeting_location",         limit: 50
  end

  create_table "item_category", primary_key: "type", force: :cascade do |t|
  end

  create_table "item_condition", primary_key: "condition", force: :cascade do |t|
  end

  create_table "item_list", primary_key: "item_id", force: :cascade do |t|
    t.string  "type",             limit: 50, null: false
    t.string  "model",            limit: 50
    t.float   "age"
    t.string  "condition",        limit: 50, null: false
    t.date    "date_entered",                null: false
    t.string  "user_id",          limit: 50, null: false
    t.string  "location",         limit: 50, null: false
    t.boolean "is_loaned",                   null: false
    t.string  "current_contract", limit: 50
    t.date    "available_from"
    t.float   "min_loan_period"
    t.float   "max_loan_period"
    t.float   "deposit",                     null: false
    t.float   "rental_rate",                 null: false
  end

  create_table "user", force: :cascade do |t|
    t.string   "username"
    t.string   "email"
    t.string   "firstname"
    t.string   "lastname"
    t.string   "streetaddress"
    t.string   "city"
    t.string   "country"
    t.string   "postcode"
    t.string   "phoneprimary"
    t.string   "phonesecondary"
    t.date     "birthdate"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  create_table "users", primary_key: "user_id", force: :cascade do |t|
    t.string "name_first",         limit: 25,  null: false
    t.string "name_last",          limit: 50,  null: false
    t.string "street_address",     limit: 100
    t.string "city",               limit: 50
    t.string "country",            limit: 50
    t.string "postcode",           limit: 25
    t.string "phone_primary",      limit: 50
    t.string "phone_secondary",    limit: 50
    t.string "encrypted_password", limit: 50,  null: false
    t.string "email",              limit: 50,  null: false
    t.date   "birthdate"
    t.string "credit_card",        limit: 16
    t.float  "feedback_rating"
  end

  add_foreign_key "contracts_history", "interest_history", column: "key", primary_key: "key", name: "contracts_history_key_fkey"
  add_foreign_key "item_list", "contracts_history", column: "current_contract", primary_key: "contract_id", name: "item_list_current_contract_fkey"
  add_foreign_key "item_list", "item_category", column: "type", primary_key: "type", name: "item_list_type_fkey"
  add_foreign_key "item_list", "item_condition", column: "condition", primary_key: "condition", name: "item_list_condition_fkey"
end
