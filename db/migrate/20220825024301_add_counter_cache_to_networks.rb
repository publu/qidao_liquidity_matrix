class AddCounterCacheToNetworks < ActiveRecord::Migration[7.0]
  def change
    add_column :networks, :tokens_count, :integer, default: 0, null: false
  end
end
