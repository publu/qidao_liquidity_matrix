class AddNetworkToTokens < ActiveRecord::Migration[7.0]
  def change
    add_reference :tokens, :network, null: false, foreign_key: true
  end
end
