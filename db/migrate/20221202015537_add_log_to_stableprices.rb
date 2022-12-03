class AddLogToStableprices < ActiveRecord::Migration[7.0]
  def change
    add_column :stableprices, :natural_log, :decimal
  end
end
