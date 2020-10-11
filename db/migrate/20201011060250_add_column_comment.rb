class AddColumnComment < ActiveRecord::Migration[5.2]
  def change
    add_column :comments, :delete_check, :integer, default: 0
  end
end
