class AddContractaddressToTokens < ActiveRecord::Migration[7.0]
  def change
    add_column :tokens, :contract_address, :string
  end
end
