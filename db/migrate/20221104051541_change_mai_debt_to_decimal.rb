class ChangeMaiDebtToDecimal < ActiveRecord::Migration[7.0]
  def change
    change_column :tokens, :mai_debt, :decimal, :precision => 32, :scale => 2, default: 0
  end
end
