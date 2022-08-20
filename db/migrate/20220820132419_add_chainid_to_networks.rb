class AddChainidToNetworks < ActiveRecord::Migration[7.0]
  def change
    add_column :networks, :chain_id, :string
  end
end
