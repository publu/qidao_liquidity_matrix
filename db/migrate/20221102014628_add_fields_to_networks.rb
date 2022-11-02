class AddFieldsToNetworks < ActiveRecord::Migration[7.0]
  def change
    add_column :networks, :liquidity, :float, default: 0
    add_column :networks, :volume, :float, default: 0
    add_column :networks, :debtamount, :float, default: 0
    add_column :networks, :debtpercent, :decimal, default: 0
  end
end
