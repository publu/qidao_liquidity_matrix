class CreateStableprices < ActiveRecord::Migration[7.0]
  def change
    create_table :stableprices do |t|
      t.string :asset
      t.decimal :closing_price
      t.decimal :volatility
      t.datetime :price_date
      t.references :stable, null: false, foreign_key: true

      t.timestamps
    end
  end
end
