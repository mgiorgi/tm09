class GroupsController < ApplicationController
  layout 'enter'
  def index
    article = Article.find_by_title(Article::Section::TALLERES_INICIO)
    @content = article && !article.content.blank? ? CGI::unescape(article.content) : ''
    if @content.blank?
      render :partial => 'shared/under_construction', :layout => 'enter'
    else
      render :partial => 'articles/show', :layout => 'enter'
    end
  end
end
