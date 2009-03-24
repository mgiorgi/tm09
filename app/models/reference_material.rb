class ReferenceMaterial < ActiveRecord::Base
  belongs_to :category
  file_column :filename
end
