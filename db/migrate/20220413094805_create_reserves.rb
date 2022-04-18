class CreateReserves < ActiveRecord::Migration[6.0]
  def change
    create_table :reserves do |t|
      t.string :reserve_on
      t.string :remark
      t.references :customer, null: false, foreign_key: true
      t.references :address,  null: false, foreign_key: true
      t.timestamps
    end
  end
end
