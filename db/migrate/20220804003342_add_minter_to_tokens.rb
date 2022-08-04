class AddMinterToTokens < ActiveRecord::Migration[7.0]
  def change
    add_reference :tokens, :minter, foreign_key: true
  end
end
