class AddIndexToUsersEmail < ActiveRecord::Migration[5.1]
  def change
    add_index :potepan_users, :email, unique: true
  end
end
