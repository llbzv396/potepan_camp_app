class RemoveProductsIdsFromPotepanOrder < ActiveRecord::Migration[5.1]
  def change
    remove_column :potepan_orders, :product_ids, :text
    remove_column :potepan_orders, :number, :integer
  end
end
