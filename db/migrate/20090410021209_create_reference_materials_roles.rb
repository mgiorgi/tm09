class CreateReferenceMaterialsRoles < ActiveRecord::Migration
  def self.up
    # generate the join table
    create_table "reference_materials_roles", :id => false do |t|
      t.integer "reference_material_id", "role_id"
    end
    add_index "reference_materials_roles", "reference_material_id"
    add_index "reference_materials_roles", "role_id"
  end

  def self.down
    drop_table "reference_materials_roles"
  end
end
