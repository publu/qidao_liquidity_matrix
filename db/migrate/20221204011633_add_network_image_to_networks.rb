class AddNetworkImageToNetworks < ActiveRecord::Migration[7.0]
  def change
    add_column :networks, :image, :string
  end
end
