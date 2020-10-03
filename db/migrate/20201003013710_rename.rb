class Rename < ActiveRecord::Migration[5.2]
  def change
    rename_column :products,:condition,:condition_id
    rename_column :products,:sendingday,:sendingday_id
    rename_column :products,:postage,:postage_id
    rename_column :products,:prefecture_code,:prefecture_code_id
    rename_column :products,:sendingtype,:sendingtype_id
    rename_column :products,:size,:size_id
  end
end
