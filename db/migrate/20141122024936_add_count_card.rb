class AddCountCard < ActiveRecord::Migration
  def change
    add_column :cards, :right_repetition_count, :integer, default: 0
    add_column :cards, :wrong_repetition_count, :integer, default: 0
    add_column :cards, :guessed, :boolean, default: false
  end
end
