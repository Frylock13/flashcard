class AddAttachmentImageToPacks < ActiveRecord::Migration
  def self.up
    change_table :packs do |t|
      t.attachment :image
    end
  end

  def self.down
    remove_attachment :packs, :image
  end
end
