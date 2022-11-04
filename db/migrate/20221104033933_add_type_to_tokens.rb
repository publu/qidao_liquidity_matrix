class AddTypeToTokens < ActiveRecord::Migration[7.0]
  def change
    add_column :tokens, :token_type, :string, default: "Volatile"
  end
end
