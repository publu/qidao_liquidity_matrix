class AddCoingeckoToTokens < ActiveRecord::Migration[7.0]
  def change
    add_column :tokens, :coingecko, :string
  end
end
