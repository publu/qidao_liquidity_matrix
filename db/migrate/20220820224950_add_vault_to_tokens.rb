class AddVaultToTokens < ActiveRecord::Migration[7.0]
  def change
    add_column :tokens, :vault_address, :string
  end
end
