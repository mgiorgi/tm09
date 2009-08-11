class GroupsController < ApplicationController
  layout 'enter'
  caches_page :index
  def index
    article = Article.find_by_title(Article::Section::ESTIMULACION_MEMORIA)
    @content = article && !article.content.blank? ? article.final_content : ''
    if @content.blank?
      render :partial => 'shared/under_construction', :layout => 'enter'
    else
      render :partial => 'articles/show', :layout => 'enter'
    end
  end
end
