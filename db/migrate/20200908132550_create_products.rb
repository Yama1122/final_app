class CreateProducts < ActiveRecord::Migration[5.2]
  def change
    create_table :products do |t|
      t.string :name, null:false
      t.text :profile, null:false
      t.integer :price, null:false
      t.references :category, type: :bigint, foreign_key: true
      t.references :brand, type: :bigint, foreign_key: true
      t.integer :size, null:false
      t.integer :condition, null:false
      t.integer :sendingday, null:false
      t.integer :postage, null:false
      t.integer :prefecture_code, null:false
      t.integer :sendingtype, null:false
      t.references :seller, type: :bigint, foreign_key: { to_table: :users }
      t.references :buyer, type: :bigint, foreign_key: { to_table: :users }
      t.datetime :deal_closed_day
      t.timestamps
    end
  end
end
