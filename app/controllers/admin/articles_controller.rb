class Admin::ArticlesController < Admin::BaseController
  active_scaffold :articles do |config|
    config.label = "Artículo"
    config.create.columns = [:title, :content]
    config.update.columns = [:title, :content]
    list.columns.exclude :content #exclude description column in list 
  end
end
