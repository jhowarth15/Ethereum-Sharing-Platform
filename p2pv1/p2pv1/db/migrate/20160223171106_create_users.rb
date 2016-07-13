class CreateUsers < ActiveRecord::Migration

  def change
    create_table "users", primary_key: "user_id", force: :cascade do |t|
      t.string "name_first",         limit: 25,  null: false
      t.string "name_last",          limit: 50,  null: false
      t.string "street_address",     limit: 100
      t.string "city",               limit: 50
      t.string "country",            limit: 50
      t.string "postcode",           limit: 25
      t.string "phone_primary",      limit: 50
      t.string "phone_secondary",    limit: 50
      t.string "encrypted_password", limit: 50,  null: false
      t.string "email",              limit: 50,  null: false
      t.date   "birthdate"
      t.string "credit_card",        limit: 16
      t.float  "feedback_rating"
    end
  end

#  def change
#    change_column :users, :city, :string, :null=>true
#    change_column :users, :country, :string, :null=>true
#    change_column :users, :postcode, :string, :null=>true
#  end
  
end
