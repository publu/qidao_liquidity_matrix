class AddColorToNetworks < ActiveRecord::Migration[7.0]
  def change
    add_column :networks, :color, :string
  end
end
