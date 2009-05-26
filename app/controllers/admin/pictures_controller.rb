class Admin::PicturesController < ApplicationController
  active_scaffold :pictures do |config|
    config.label = "Fotos para artículos"
    config.create.columns = [:title, :description, :filename]
    config.create.columns.add_subgroup "Name" do |name_group|
      name_group.add :title, :description, :filename
    end    
    config.update.columns = [:title, :description, :filename]
    config.update.columns.add_subgroup "Name" do |name_group|
      name_group.add :title, :description, :filename
    end    
    list.columns.exclude :type
  end
end
