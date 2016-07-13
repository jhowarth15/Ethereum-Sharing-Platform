class TemporarilyDropContractsTable < ActiveRecord::Migration
  def change
	drop_table :contracts
  end
end
