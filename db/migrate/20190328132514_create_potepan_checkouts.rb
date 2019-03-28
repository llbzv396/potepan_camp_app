class CreatePotepanCheckouts < ActiveRecord::Migration[5.1]
  def change
    create_table :potepan_checkouts do |t|
      t.text :name
      t.text :email
      t.text :postal
      t.text :streetaddress
      t.text :phone
      t.integer :order_id

      t.timestamps
    end
  end
end
