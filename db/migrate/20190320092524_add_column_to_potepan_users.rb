class AddColumnToPotepanUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :potepan_users, :phone, :integer
  end
end
