class CreateOrderItems < ActiveRecord::Migration[6.0]
  def change
    create_table :order_items do |t|
      t.string  :shop_name,null: false
      t.string  :name,     null: false
      t.string  :variety,  null: false
      t.string  :rank,     null: false
      t.integer :weight,   null: false
      t.integer :price, null: false
      t.integer :quantity, null: false
      t.integer :postage,  null: false
      t.references :reserve, null: false, foreign_key: true
      t.timestamps
    end
  end
end
