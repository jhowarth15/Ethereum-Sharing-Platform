class CreateContracts < ActiveRecord::Migration
  def change
    create_table :contracts do |t|
      t.date :created_at
      t.integer :item_id
      t.string :lender_id
      t.string :inquirer_id
      t.string :key
      t.date :loaned_out
      t.date :returned
      t.float :deposit
      t.float :rental_rate

      t.timestamps null: false
    end
  end
end
