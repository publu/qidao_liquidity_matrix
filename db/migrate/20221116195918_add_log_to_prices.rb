class AddLogToPrices < ActiveRecord::Migration[7.0]
  def change
    add_column :prices, :natural_log, :decimal
  end
end
