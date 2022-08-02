class AddSlugToNetworks < ActiveRecord::Migration[7.0]
  def change
    add_column :networks, :slug, :string
    add_index :networks, :slug, unique: true
  end
end
