class Order < ActiveRecord::Migration[5.1]
  def change
    add_column :potepan_orders, :user_id, :integer
  end
end
