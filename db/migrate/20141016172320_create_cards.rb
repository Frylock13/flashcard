class CreateCards < ActiveRecord::Migration
  def change
    create_table :cards do |t|
      t.string :origin_text
      t.string :translated_text
      t.date :review_date

      t.timestamps
    end
  end
end
