class CreateAddresses < ActiveRecord::Migration[6.0]
  def change
    create_table :addresses do |t|
      t.references :customer          , null: false, foreign_key: true
      t.string     :last_name         , null: false
      t.string     :first_name        , null: false
      t.string     :last_name_kana    , null: false
      t.string     :first_name_kana   , null: false
      t.string     :phone_number      
      t.string     :fax_number        
      t.string     :postal_code       , null: false
      t.string     :prefecture        , null: false
      t.string     :city              , null: false
      t.string     :town              , null: false
      t.string     :extended_address
      t.timestamps
    end
  end
end
