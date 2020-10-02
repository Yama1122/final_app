class CreateProducts < ActiveRecord::Migration[5.2]
  def change
    create_table :products do |t|
      t.string :name, null:false
      t.text :profile, null:false
      t.integer :price, null:false
      t.references :category, type: :bigint, foreign_key: true
      t.references :brand, type: :bigint, foreign_key: true
      t.integer :size_id, null:false
      t.integer :condition_id, null:false
      t.integer :sendingday_id, null:false
      t.integer :postage_id, null:false
      t.integer :prefecture_code_id, null:false
      t.integer :sendingtype_id, null:false
      t.references :seller, type: :bigint, foreign_key: { to_table: :users }
      t.references :buyer, type: :bigint, foreign_key: { to_table: :users }
      t.datetime :deal_closed_day
      t.string   :status_id, default:  "出品中"
      t.timestamps
    end
  end
end
