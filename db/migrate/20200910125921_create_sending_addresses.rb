class CreateSendingAddresses < ActiveRecord::Migration[5.2]
  def change
    create_table :sending_addresses do |t|
      t.string         :first_name,        null: false
      t.string         :family_name,       null: false
      t.string         :first_name_kana,   null: false
      t.string         :family_name_kana,  null: false
      t.string         :post_code,         null: false
      t.integer        :prefecture_code,   null: false
      t.string         :city,              null: false
      t.string         :house_number,      null: false
      t.string         :building_name     
      t.string         :phone_number,      unique: true
      t.references     :user,              foreign_key: true
      t.timestamps
    end
  end
end
