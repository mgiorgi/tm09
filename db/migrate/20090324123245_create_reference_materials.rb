class CreateReferenceMaterials < ActiveRecord::Migration
  def self.up
    create_table :reference_materials do |t|
      t.string :title
      t.string :description
      t.string :filename
      t.timestamps
    end
  end

  def self.down
    drop_table :reference_materials
  end
end
