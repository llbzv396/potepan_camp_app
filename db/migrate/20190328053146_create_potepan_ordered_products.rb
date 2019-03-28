class CreatePotepanOrderedProducts < ActiveRecord::Migration[5.1]
  def change
    create_table :potepan_ordered_products do |t|
      t.integer :order_id
      t.integer :product_id

      t.timestamps
    end
  end
end
