class ReferenceMaterial < ActiveRecord::Base
  has_and_belongs_to_many :roles
  file_column :filename

  def full_path
    "/#{self.class.to_s.tableize.singularize}/filename/#{self.filename_relative_path}"
  end
end
