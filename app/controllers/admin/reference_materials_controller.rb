class Admin::ReferenceMaterialsController < Admin::BaseController
  active_scaffold :reference_materials do  |config|
    config.label = "Material de Referencia"
    #config.columns.add :uploaded_data
    #config.create.multipart = true
    #config.update.multipart = true
    #config.columns = [:title, :description, :category, :filename]
    #config.nested.add_link("Attach", [:attachments])
    ##config.subform.columns.exclude :data
    #config.create.multipart = true
    ##list.sorting = {:name => 'ASC'}
  end

end
