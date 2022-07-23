class CreateTokens < ActiveRecord::Migration[7.0]
  def change
    create_table :tokens do |t|
      t.string :asset
      t.string :symbol
      t.float :liquidity
      t.float :trade_slippage
      t.float :volume
      t.boolean :centralized
      t.string :grade

      t.timestamps
    end
  end
end
