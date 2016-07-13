class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.string :name
      t.string :type
      t.string :model
      t.float :age
      t.string :location
      t.float :min_loan_period
      t.float :max_loan_period
      t.float :deposit
      t.float :rental_rate

      t.timestamps null: false
    end
  end

end
