class CreateAttachments < ActiveRecord::Migration
  def self.up
    create_table :attachments do |t|
      t.string :title
      t.string :description
      t.string :filename
      t.string :type
      t.timestamps
    end
  end

  def self.down
    drop_table :attachments
  end
end
