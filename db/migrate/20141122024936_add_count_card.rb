class AddCountCard < ActiveRecord::Migration
  def change
    add_column :cards, :successful_repeat_count, :integer, default: 0
    add_column :cards, :fail_repeat_count, :integer, default: 0
    add_column :cards, :guesed, :boolean, default: false
  end
end
