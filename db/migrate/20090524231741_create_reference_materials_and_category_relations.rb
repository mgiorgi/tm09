class CreateReferenceMaterialsAndCategoryRelations < ActiveRecord::Migration
  def self.up
    create_table :categories_reference_materials, :id => false do |t|
      t.column :reference_material_id, :integer
      t.column :category_id, :integer
    end
  end

  def self.down
    drop_table :categories_reference_materials
  end
end
