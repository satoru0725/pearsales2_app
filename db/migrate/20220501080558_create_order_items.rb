class CreateOrderItems < ActiveRecord::Migration[6.0]
  def change
    create_table :order_items do |t|
      t.integer :quantity, null: false
      t.integer :price, null: false
      t.references :product, null: false, foreign_key: true
      t.references :reserve, null: false, foreign_key: true
      t.timestamps
    end
  end
end
