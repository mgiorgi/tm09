class DropReferenceMaterial < ActiveRecord::Migration
  def self.up
    drop_table :reference_materials
  end

  def self.down
    create_table :reference_materials do |t|
      t.string :title
      t.string :description
      t.string :filename
      t.timestamps
    end
  end
end
