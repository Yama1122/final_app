class ChangeColumnNotNull < ActiveRecord::Migration[5.2]
  def up
    change_column :products, :size_id,:string, null: false
  end

  def down
    change_column :products, :size_id,:string
  end
end
