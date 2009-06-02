class CreateGroupPictures < ActiveRecord::Migration
  def self.up
    create_table :group_pictures do |t|
      t.text :description
      t.string :filename
      t.timestamps
    end
  end

  def self.down
    drop_table :group_pictures
  end
end
