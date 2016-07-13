class AddEtherAccountToUsers < ActiveRecord::Migration
  def change
    add_column :users, :ether_account, :string
  end
end
