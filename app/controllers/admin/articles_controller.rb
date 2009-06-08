class Admin::ArticlesController < Admin::BaseController
  cache_sweeper :article_sweeper, :only => [:create, :update, :destroy]
  active_scaffold :articles do |config|
    config.label = "Artículo"
    config.create.columns = [:title, :body]
    config.update.columns = [:title, :body]
    list.columns.exclude :content, :body #exclude description column in list 
  end
end
