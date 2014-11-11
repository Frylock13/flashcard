class AddCurrentColumn < ActiveRecord::Migration
  def change
    add_column :users, :pack_id, :integer
  end
end
