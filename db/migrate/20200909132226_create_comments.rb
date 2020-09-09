class CreateComments < ActiveRecord::Migration[5.2]
  def change
    create_table :comments do |t|
      t.text :body, null:false
      t.references :user, null:false, foreign_key:true
      t.references :product, null:false, foreign_key:true
      t.datetime :created_at
      t.timestamps
    end
  end
end
