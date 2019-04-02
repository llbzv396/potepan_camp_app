class AddColumnsToCheckout < ActiveRecord::Migration[5.1]
  def change
    add_column :potepan_checkouts, :state, :integer
  end
end
