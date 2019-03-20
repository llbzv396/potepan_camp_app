class ChangeDatatypePotepanUsersOfPhonePostal < ActiveRecord::Migration[5.1]
  def change
    change_column :potepan_users, :phone, :text
    change_column :potepan_users, :postal, :text
  end
end
