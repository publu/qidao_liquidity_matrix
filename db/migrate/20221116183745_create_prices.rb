class CreatePrices < ActiveRecord::Migration[7.0]
  def change
    create_table :prices do |t|
      t.string :asset
      t.decimal :closing_price
      t.decimal :prev_closing_price
      t.decimal :volatility
      t.datetime :price_date
      t.references :token, null: false, foreign_key: true

      t.timestamps
    end
  end
end
