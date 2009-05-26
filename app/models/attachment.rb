class Attachment < ActiveRecord::Base
  file_column :filename
  def full_path
    "/attachment/filename/#{self.filename_relative_path}"
  end
end
