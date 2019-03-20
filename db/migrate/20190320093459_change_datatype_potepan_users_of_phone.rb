class ChangeDatatypePotepanUsersOfPhone < ActiveRecord::Migration[5.1]
  def change
    change_column :potepan_users, :phone, :numeric
  end
end
