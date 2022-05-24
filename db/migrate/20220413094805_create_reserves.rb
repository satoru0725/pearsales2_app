class CreateReserves < ActiveRecord::Migration[6.0]
  def change
    create_table :reserves do |t|
      t.date       :reserve_on,  null: false
      t.string     :remark
      t.integer    :total_price, null: false
      t.references :customer,    null: false, foreign_key: true
      t.references :address,     null: false, foreign_key: true
      t.timestamps
    end
  end
end
