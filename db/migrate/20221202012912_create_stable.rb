class CreateStable < ActiveRecord::Migration[7.0]
  def change
    create_table :stables do |t|
      t.string :symbol
      t.string :asset
      t.string :gecko_id
      t.string :contract_address
      t.decimal :risk_volatility, :precision => 10, :scale => 4

      t.timestamps
    end
  end
end
