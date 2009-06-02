class Admin::GroupPicturesController < ApplicationController
  active_scaffold :group_pictures do |config|
    config.label = "Galeria"
    config.create.columns = [:description, :filename]
    config.update.columns = [:description, :filename]
    list.columns.exclude :title, :type
  end
end
