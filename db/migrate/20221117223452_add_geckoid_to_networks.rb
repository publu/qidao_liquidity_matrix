class AddGeckoidToNetworks < ActiveRecord::Migration[7.0]
  def change
    add_column :networks, :gecko_id, :string
  end
end
