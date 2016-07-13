class AddContractAdressToContracts < ActiveRecord::Migration
  def change
    add_column :contracts, :contract_address, :string
  end
end
