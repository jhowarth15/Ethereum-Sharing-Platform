class AddIndexToUsersEmail < ActiveRecord::Migration
  def change
    add_index :users, :user_id, unique: true
    add_index :users, :email, unique: true
  end
end
