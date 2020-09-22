class NotNullToUser < ActiveRecord::Migration[5.2]
  def up
    change_column :users, :introduction,:text, null: true
  end

  def down
    change_column :users, :introduction,:string, null: false
  end
end
