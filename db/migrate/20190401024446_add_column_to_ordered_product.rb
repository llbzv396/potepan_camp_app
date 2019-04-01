class AddColumnToOrderedProduct < ActiveRecord::Migration[5.1]
  def change
    add_column :potepan_ordered_products, :count, :integer
  end
end
