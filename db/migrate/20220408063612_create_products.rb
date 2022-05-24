class CreateProducts < ActiveRecord::Migration[6.0]
  def change
    create_table :products do |t|
      t.string     :name,      null: false
      t.string     :variety,   null: false
      t.string     :rank,      null: false
      t.integer    :weight,    null: false
      t.integer    :price,     null: false
      t.integer    :stock,     null: false
      t.integer    :postage,   null: false
      t.text       :remark    
      t.boolean    :suspended, null: false, default: false
      t.references :user,      null: false, foreign_key: true
      t.timestamps
    end
  end
end
