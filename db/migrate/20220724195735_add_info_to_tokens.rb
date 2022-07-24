class AddInfoToTokens < ActiveRecord::Migration[7.0]
  def change
    add_column :tokens, :coinmarketcap, :string
    add_column :tokens, :contract_days, :integer
    add_column :tokens, :contract_transactions, :integer
    add_column :tokens, :holders, :integer
    add_column :tokens, :permissions, :string
    add_column :tokens, :risk_marketcap, :float
    add_column :tokens, :risk_volume, :float
    add_column :tokens, :risk_volatility, :decimal, :precision => 10, :scale => 4
  end
end
