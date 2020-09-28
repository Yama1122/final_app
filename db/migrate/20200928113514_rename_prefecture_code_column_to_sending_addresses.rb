class RenamePrefectureCodeColumnToSendingAddresses < ActiveRecord::Migration[5.2]
  def change
    rename_column :sending_addresses, :prefecture_code, :prefecture_code_id
  end
end
