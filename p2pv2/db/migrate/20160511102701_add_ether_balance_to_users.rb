class AddEtherBalanceToUsers < ActiveRecord::Migration
  def change
    add_column :users, :ether_balance, :float
  end
end
