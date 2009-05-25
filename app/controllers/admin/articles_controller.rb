class Admin::ArticlesController < Admin::BaseController
  active_scaffold :articles do |config|
    config.label = "Artículo"
    config.create.columns = [:title, :body]
    config.update.columns = [:title, :body]
    list.columns.exclude :content, :body #exclude description column in list 
  end
end
