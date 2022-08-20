class AddDebtToTokens < ActiveRecord::Migration[7.0]
  def change
    add_column :tokens, :mai_debt, :float
  end
end
