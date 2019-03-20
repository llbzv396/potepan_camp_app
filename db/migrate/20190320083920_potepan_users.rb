class PotepanUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :potepan_users, :postal, :integer
    add_column :potepan_users, :streetaddress, :string
  end
end
