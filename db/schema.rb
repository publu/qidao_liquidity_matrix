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

ActiveRecord::Schema[7.0].define(version: 2022_07_24_195735) do
  create_table "networks", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "color"
    t.string "blockchain_explorer"
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
    t.index ["network_id"], name: "index_tokens_on_network_id"
  end

  add_foreign_key "tokens", "networks"
end
