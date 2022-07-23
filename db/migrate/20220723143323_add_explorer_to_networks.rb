class AddExplorerToNetworks < ActiveRecord::Migration[7.0]
  def change
    add_column :networks, :blockchain_explorer, :string
  end
end
