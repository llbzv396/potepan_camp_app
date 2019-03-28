class CreatePotepanOrders < ActiveRecord::Migration[5.1]
  def change
    create_table :potepan_orders do |t|
      t.integer :number
      t.integer :item_total
      t.integer :total_price
      t.text :state
      t.text :product_ids

      t.timestamps
    end
  end
end
