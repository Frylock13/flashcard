class RenameColumnCurrentPack < ActiveRecord::Migration
  def change
    rename_column :users, :pack_id, :current_pack_id
  end
end
