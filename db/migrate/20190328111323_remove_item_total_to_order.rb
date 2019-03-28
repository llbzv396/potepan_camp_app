class RemoveItemTotalToOrder < ActiveRecord::Migration[5.1]
  def change
    remove_column :potepan_orders, :item_total, :integer
    remove_column :potepan_orders, :total_price, :integer
  end
end
