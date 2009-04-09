class ReferenceMaterial < ActiveRecord::Base
  belongs_to :category
  file_column :filename

  def full_path
    "/#{self.class.to_s.tableize.singularize}/filename/#{self.filename_relative_path}"
  end
end
