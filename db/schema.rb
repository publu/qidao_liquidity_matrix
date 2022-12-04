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

ActiveRecord::Schema[7.0].define(version: 2022_12_04_011633) do
  create_table "friendly_id_slugs", force: :cascade do |t|
    t.string "slug", null: false
    t.integer "sluggable_id", null: false
    t.string "sluggable_type", limit: 50
    t.string "scope"
    t.datetime "created_at"
    t.index ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true
    t.index ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type"
    t.index ["sluggable_type", "sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_type_and_sluggable_id"
  end

  create_table "minters", force: :cascade do |t|
    t.string "name"
    t.string "link"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "slug"
    t.index ["slug"], name: "index_minters_on_slug", unique: true
  end

  create_table "networks", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "color"
    t.string "blockchain_explorer"
    t.string "slug"
    t.string "chain_id"
    t.integer "tokens_count", default: 0, null: false
    t.float "liquidity", default: 0.0
    t.float "volume", default: 0.0
    t.float "debtamount", default: 0.0
    t.decimal "debtpercent", default: "0.0"
    t.string "gecko_id"
    t.string "image"
    t.index ["slug"], name: "index_networks_on_slug", unique: true
  end

  create_table "prices", force: :cascade do |t|
    t.string "asset"
    t.decimal "closing_price"
    t.decimal "prev_closing_price"
    t.decimal "volatility"
    t.datetime "price_date"
    t.integer "token_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.decimal "natural_log"
    t.index ["token_id"], name: "index_prices_on_token_id"
  end

  create_table "stableprices", force: :cascade do |t|
    t.string "asset"
    t.decimal "closing_price"
    t.decimal "volatility"
    t.datetime "price_date"
    t.integer "stable_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.decimal "natural_log"
    t.index ["stable_id"], name: "index_stableprices_on_stable_id"
  end

  create_table "stables", force: :cascade do |t|
    t.string "symbol"
    t.string "asset"
    t.string "gecko_id"
    t.string "contract_address"
    t.decimal "risk_volatility", precision: 10, scale: 4
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "tokens", force: :cascade do |t|
    t.string "asset"
    t.string "symbol"
    t.float "liquidity"
    t.float "trade_slippage"
    t.float "volume"
    t.boolean "centralized"
    t.string "grade"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "network_id", null: false
    t.string "contract_address"
    t.string "coingecko"
    t.string "rubric"
    t.string "coinmarketcap"
    t.integer "contract_days"
    t.integer "contract_transactions"
    t.integer "holders"
    t.string "permissions"
    t.float "risk_marketcap"
    t.float "risk_volume"
    t.decimal "risk_volatility", precision: 10, scale: 4
    t.string "slug"
    t.integer "minter_id"
    t.decimal "mai_debt", precision: 32, scale: 2, default: "0.0"
    t.string "vault_address"
    t.string "token_type", default: "Volatile"
    t.index ["minter_id"], name: "index_tokens_on_minter_id"
    t.index ["network_id"], name: "index_tokens_on_network_id"
    t.index ["slug"], name: "index_tokens_on_slug", unique: true
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "role", default: 0
    t.integer "failed_attempts", default: 0, null: false
    t.string "unlock_token"
    t.datetime "locked_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "prices", "tokens"
  add_foreign_key "stableprices", "stables"
  add_foreign_key "tokens", "minters"
  add_foreign_key "tokens", "networks"
end
