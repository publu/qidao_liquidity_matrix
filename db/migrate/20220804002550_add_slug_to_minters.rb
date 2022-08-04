class AddSlugToMinters < ActiveRecord::Migration[7.0]
  def change
    add_column :minters, :slug, :string
    add_index :minters, :slug, unique: true
  end
end
