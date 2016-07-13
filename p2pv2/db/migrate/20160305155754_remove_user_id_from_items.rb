class RemoveUserIdFromItems < ActiveRecord::Migration
  def change
    remove_column :items, :user_id, :string
  end
end
