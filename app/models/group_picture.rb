class GroupPicture < ActiveRecord::Base
  file_column :filename, :magick => { :versions => { "thumb" => "200x200" } }
end
