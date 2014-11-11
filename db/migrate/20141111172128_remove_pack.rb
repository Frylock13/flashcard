class RemovePack < ActiveRecord::Migration
  def change
    remove_column :packs, :current
  end
end
